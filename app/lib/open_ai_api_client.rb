require 'openai'

class OpenAiApiClient
  def initialize(api_key)
    @client = OpenAI::Client.new(access_token: api_key)
  end

  def create_quiz(title, goal, instructions)
    text = "Can you generate a quiz in JSON format to test a student's understanding on the following topic: #{title}?
    The title is: #{title} (The theme of the quiz), the goals are: #{goal} (The goals and objectives of the quiz), the instructions are #{instructions} (Any special instructions or pieces of context required for the generation of the quiz)
    You have to generate a set of 5 questions where there is only one correct answer for each question. The quiz should include multiple-choice questions that cover various aspects of the theme provided by the user and if any useful instructions (or any at all) are given try and follow them as much as possible.
    Each question should have 3-5 plausible answer choices, with only one being the correct answer.
    Formatting: The JSON output should follow the format you provided previously, with clear separation between quiz text (title, goal, instructions) and quiz data (questions, tags, options, answers). Each option should include two attributes: option, and a boolean to indicate if its the correct  answer or not. Additionally, please ensure the quiz adheres to best practices for objective test creation, including: Single idea per question, Objective phrasing of questions, Plausible distractors in answer choices, Randomized order of correct answers, Similar answer length for each option, No grammatical clues in wording (important), Formatted answer options (indented and displayed clearly), Do not use options like all of the above, none of the above, I don't know, Do not give question or answers that are subjective to the student. Also
    Important: Before replying verify that the correct answer you are providing is actually correct. Take your time for this, there is no rush in delivering a quiz if the answers are wrong.
    Always format the JSON file appropriately and use the same format. Do not provide any explanations, just return me the generated quiz. Take your time"

    messages = [{ type: 'text', text: }]

    response = @client.chat(
      parameters: {
        model: 'gpt-4',
        messages: [{ role: 'user', content: messages }]
      }
    )

    parse_response(response)
  end

  def test_query(text, json_format)
    messages = [
      { 
        type: 'text', 
        text: text
      }
      { 
        type: 'text', 
        text: "Your response must exactly follow the following format: #{json_format}"
      }
    ]

    response = @client.chat(
      parameters: {
        model: 'gpt-4',
        messages: [{ role: 'user', content: messages }]
      }
    )

    parse_response(response)
  end

  private

  def parse_response(response)
    content = response['choices'][0]['message']['content']
    JSON.parse(content)
  end
end
