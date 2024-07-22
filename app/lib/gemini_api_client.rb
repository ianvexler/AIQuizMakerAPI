require 'gemini-ai'

class GeminiApiClient
  def initialize(api_key)
    @client = Gemini.new(
      credentials: {
        service: 'generative-language-api',
        api_key:
      },
      options: {
        model: 'gemini-pro',
        server_sent_events: false
      }
    )

    self.class.rescue_from(Faraday::BadRequestError, with: :handle_bad_request)
  end

  def create_question(topic, difficulty)
    with_error_handling do
      response = @client.stream_generate_content(
        {
          contents: {
            role: 'user',
            parts: [
              {
                text: "You are a quiz question the user will pass the following parameters and you have to generate a quiz question based on them. Parameters: topic, difficulty, description (description of the topic), context (optional). The question should be based as much as possible in these parameters. Your response has to follow a JSON output following the instructions below. Each question should have 4 answers related to it.\n\nThe JSON output should follow the following format: content (content of the question), tags, options and confidence (0 to 100 value representing the percentage of how confident you are that the response is correct). Each of the options should have the following format: value (the content or value of the response), is_correct (if the answer is the correct answer).\n\nAfter generating the question you have to verify that the answer is correct before returning an output. If the answer is incorrect, you have to do any changes required to the question and/or answers so that it provides a valid response. This is very important so you can take as much time as possible.\n\nAdditionally, please ensure the quiz adheres to best practices for objective test creation, including: Single idea per question, Objective phrasing of questions, Plausible distractors in answer choices, Randomized order of correct answers, Similar answer length for each option, No grammatical clues in wording (important), Formatted answer options (indented and displayed clearly), Do not use options like \"all of the above\", \"none of the above\",\" I don't know\", Do not give question or answers that are subjective to the student."
              },
              {
                text: "Topic: #{topic.name}, Difficulty: #{difficulty.name}, Description: #{topic.description}"
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
                text: "You are a question validator, you will receive a string that can be parsed into a JSON containing the following format: content (content of the question), tags, options and confidence (0 to 100 value representing the percentage of how confident you are that the response is correct). Each of the options should have the following format: value (the content or value of the response), is_correct (if the answer is the correct answer).\n\nYou are in charge of validating that the question provided and the option containing the correct answer work. If the question and/or the answer is wrong make any changes necessary so that it works. The question should be based as much as possible in these parameters. Your response has to follow a JSON output following the exact format as the input JSON. Each question should have 4 answers related to it.\n\nIf you had to re-generate or change the question you have to verify that the answer is correct before returning an output. If the answer is incorrect, you have to do any changes required to the question and/or answers so that it provides a valid response. This is very important so you can take as much time as possible.\n\nAdditionally, please ensure the quiz adheres to best practices for objective test creation, including: Single idea per question, Objective phrasing of questions, Plausible distractors in answer choices, Randomized order of correct answers, Similar answer length for each option, No grammatical clues in wording (important), Formatted answer options (indented and displayed clearly), Do not use options like \"all of the above\", \"none of the above\",\" I don't know\", Do not give question or answers that are subjective to the student.\n\nYour response should follow the exact same format you received but in addition you should add another attribute called is_valid which says if the validation passed. If you had to regenerate anything in the question (including the answers), then it should be false. If the validation passed without changing anything then it should be true."
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

  def handle_bad_request(exception)
    response = {
      message: exception.message,
      body: exception.response[:body]
    }
  end

  def with_error_handling
    yield
  rescue BadRequest => e
    handle_bad_request(e)
  end
end
