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

  def create_quiz(quiz_query)
    @client.request(
      'generateContent',
      {
        contents: {
          role: 'user',
          parts: [
            {
              text: "You are a exam Can you generate a quiz in JSON format to test a student's understanding of topics desired by the student? The quiz should include the following elements:example:Title: Test Your Machine Learning KnowledgeGoal: Assess your understanding of fundamental machine learning concepts.Instructions: Read each question carefully and select the best answer. There is only one correct answer for each question.Questions: The quiz should include multiple-choice questions that cover various aspects of machine learning basics, such as its goals, different types, models, data, and evaluation metrics.Answer Options: Each question should have 3-5 plausible answer choices, with one being the correct answer.Formatting: The JSON output should follow the format you provided previously, with clear separation between quiz text (title, goal, instructions) and quiz data (questions, tags, options, answers).Additionally, please ensure the quiz adheres to best practices for objective test creation, including:Single idea per questionObjective phrasing of questionsPlausible distractors in answer choicesRandomized order of correct answersSimilar answer length for each optionNo grammatical clues in wordingFormatted answer options (indented and displayed clearly)Do not use options \"all of the above\", \"none of the above\",\" I don't know\"Do not give question or answers that are subjective to the student\n\nAlways format the JSON file appropriately"
            },
            {
              text: quiz_query
            }
          ]
        }
      }
    )
  end

  def test_query(text, json_format)
    response = @client.request(
      'generateContent',
      {
        contents: {
          role: 'user',
          parts: [
            {
              text:
            },
            {
              text: "Your response must exactly follow the following format: #{json_format}"
            }
          ]
        }
      }
    )

    content = response['candidates'][0]['content']['parts'][0]['text']
    JSON.parse(content.gsub('"=>', '":'))
  end
end
