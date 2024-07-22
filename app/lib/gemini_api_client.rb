require 'gemini-ai'

class GeminiApiClient
  def initialize(api_key)
    @client = Gemini.new(
      credentials: {
        service: 'generative-language-api',
        api_key:,
        version: 'v1beta'
      },
      options: {
        model: 'gemini-1.0-pro',
        server_sent_events: false
      }
    )
  end

  def create_question(topic, difficulty)
    @client.request(
      'generateContent',
      {
        contents: {
          role: 'user',
          parts: [
            {
              text: "You are a quiz question the user will pass the following parameters and you have to generate a quiz question based on them. Parameters: topic, difficulty, description (description of the topic), context (optional). The question should be based as much as possible in these parameters. Your response has to follow a JSON output following the instructions below. Each question should have 4 answers related to it.\n\nThe JSON output should follow the following format: content (content of the question), tags, options and confidence (percentage of how confident you are that the response is correct). Each of the options should have the following format: value (the content or value of the response), is_correct (if the answer is the correct answer).\n\nAfter generating the question you have to verify that the answer is correct before returning an output. If the answer is incorrect, you have to do any changes required to the question and/or answers so that it provides a valid response. This is very important so you can take as much time as possible.\n\nAdditionally, please ensure the quiz adheres to best practices for objective test creation, including: Single idea per question, Objective phrasing of questions, Plausible distractors in answer choices, Randomized order of correct answers, Similar answer length for each option, No grammatical clues in wording (important), Formatted answer options (indented and displayed clearly), Do not use options like \"all of the above\", \"none of the above\",\" I don't know\", Do not give question or answers that are subjective to the student."
            }
          ]
        }
      }
    )
  end

  def validate_question(topic, difficulty, question_data)
    @client.request(
      'generateContent',
      {
        contents: {
          role: 'user',
          parts: [
            {
              text: ""
            }
          ]
        }
      }
    )
  end
end
