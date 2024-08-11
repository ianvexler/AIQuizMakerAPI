require 'gemini-ai'
require 'faraday'
require 'base64'

class GeminiApiClient
  def initialize(api_key)
    @client = Gemini.new(
      credentials: {
        service: 'generative-language-api',
        api_key:
      },
      options: {
        model: 'gemini-1.5-flash',
        server_sent_events: false
      }
    )
  end

  def create_question(topic, difficulty, questions)
    with_error_handling do
      response = @client.stream_generate_content(
        {
          contents: {
            role: 'user',
            parts: [
              {
                text: "You are a quiz question the user will pass the following parameters and you have to generate a quiz question based on them. Parameters: topic, difficulty, description (description of the topic), previous questions (previous questions on the quiz), context (optional). The question should be based as much as possible in these parameters. Your response has to follow a JSON output following the instructions below. Each question should have 4 answers related to it.\n\nThe prompt will include an array with the content of previous questions in the quiz, ideally a quiz should contain different questions therefore you should try and change the question or values to ensure there are no repeated quesitons.\n\nThe JSON output should follow the following format: content (content of the question), tags, options and confidence (percentage of how confident you are that the response is correct). Each of the options should have the following format: value (the content or value of the response), is_correct (if the answer is the correct answer). \n\nIn addition each question should include 3 hints. Whilst these hints should help the user, they should not reveal the answer. Return them in an array of strings where the first item is the least revealing hint and the last item is the most revealing.\n\nAfter generating the question you have to verify that the answer is correct before returning an output. If the answer is incorrect, you have to do any changes required to the question and/or answers so that it provides a valid response. This is very important so you can take as much time as possible.\n\nAdditionally, please ensure the quiz adheres to best practices for objective test creation, including: Single idea per question, Objective phrasing of questions, Plausible distractors in answer choices, Randomized order of correct answers, Similar answer length for each option, No grammatical clues in wording (important), Formatted answer options (indented and displayed clearly), Do not use options like \"all of the above\", \"none of the above\",\" I don't know\", Do not give question or answers that are subjective to the student."
              },
              {
                text: "Topic: #{topic.name}, Difficulty: #{difficulty.name}, Description: #{topic.description}, Previous Questions: #{questions}"
              }
            ]
          }
        }
      )

      parse_response(response)
    end
  end

  def validate_question(topic, difficulty, question_data)
    with_error_handling do
      response = @client.stream_generate_content(
        {
          contents: {
            role: 'user',
            parts: [
              {
                text: "You are a question validator, you will receive a group of parameters:  topic, difficulty, description (description of the topic) and question json (string that can be parsed into a JSON containing the following format: content (content of the question), tags, options and confidence (percentage of how confident you are that the response is correct)). Each of the options should have the following format: value (the content or value of the response), is_correct (if the answer is the correct answer). In addition each question should include 3 hints. Whilst these hints should help the user, they should not reveal the answer. Return them in an array of strings where the first item is the least revealing hint and the last item is the most revealing.\n\nYou are in charge of validating that the question provided and the option containing the correct answer work. If the question and/or the answer is wrong make any changes necessary so that it works. The question should be based as much as possible in these parameters. Your response has to follow a JSON output following the exact format as the input JSON. Each question should have 4 answers related to it.\n\nIf you had to re-generate or change the question you have to verify that the answer is correct before returning an output. If the answer is incorrect, you have to do any changes required to the question and/or answers so that it provides a valid response. This is very important so you can take as much time as possible. If you have to update the hints too, do so.\n\nAdditionally, please ensure the quiz adheres to best practices for objective test creation, including: Single idea per question, Objective phrasing of questions, Plausible distractors in answer choices, Randomized order of correct answers, Similar answer length for each option, No grammatical clues in wording (important), Formatted answer options (indented and displayed clearly), Do not use options like \"all of the above\", \"none of the above\",\" I don't know\", Do not give question or answers that are subjective to the student.\n\nYour response should follow the exact same format you received but in addition you should add another attribute called is_valid which says if the validation passed. If you had to regenerate anything in the question (including the answers), then it should be false. If the validation passed without changing anything then it should be true."
              },
              {
                text: "Topic: #{topic.name}, Difficulty: #{difficulty.name}, Description: #{topic.description}, Question JSON: #{question_data.to_json}"
              }
            ]
          }
        }
      )

      parse_response(response)
    end
  end

  def create_quiz_from_file(topic, file, length)
    file_content = file.read
    base64_encoded_file = Base64.strict_encode64(file_content)

    with_error_handling do
      response = @client.stream_generate_content(
        {
          contents: {
            role: 'user',
            parts: [
              {
                text: "You are a quiz where the user will pass the following parameters and you have to generate a set of questions based on them. Parameters: file, topic (name of the topic), context (optional), length. The question should be based as much as possible in these parameters. Your response has to follow a JSON output following the instructions below. Each question should have 4 answers related to it. The questions should be based on the file example provided.\n\nThe JSON output should follow the following format. For quiz: topic (the topic provided in the prompt), lenght (how many questions), questions (an array with all questions). For questions: content (content of the question), tags, options and confidence (percentage of how confident you are that the response is correct). Each of the options should have the following format: value (the content or value of the response), is_correct (if the answer is the correct answer).\n\nAfter generating the question you have to verify that the answer is correct before returning an output. If the answer is incorrect, you have to do any changes required to the question and/or answers so that it provides a valid response. This is very important so you can take as much time as possible.\n"
              },
              {
                text: "Topic: #{topic}, Length: #{length}"
              },
              {
                inline_data:
                  {
                    mime_type: file.content_type,
                    data: base64_encoded_file
                  }
              }
            ]
          }
        }
      )

      parse_response(response)
    end
  end

  private

  def parse_response(response_data)
    response_string = response_data.flat_map do |response|
      response['candidates'].flat_map do |candidate|
        candidate['content']['parts'].pluck('text')
      end
    end.join

    response_string_clean = response_string.gsub(/^``` ?json\s*|```$/i, '')

    JSON.parse(response_string_clean)
  end

  def with_error_handling
    yield
  rescue Faraday::Error => e
    {
      message: e.message,
      body: e.response[:body]
    }
  end
end
