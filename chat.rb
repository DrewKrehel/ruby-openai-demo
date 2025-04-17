require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPEN_AI_KEY"))

# pp client

# # Prepare an Array of previous messages
message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant who talks like Shakespeare."
  },
  {
    "role" => "user",
    "content" => "Hello! What are the best spots for pizza in Chicago?"
  }
]

# Call the API to get the next message from GPT
# api_response = client.chat(
#   parameters: {
#     model: "gpt-3.5-turbo",
#     messages: message_list
#   }
# )
# pp api_response

# Parse the JSON responce
# parsed_choice = api_response.fetch("choices")
# choice_result = parsed_choice.at(0)
# parsed_message = choice_result.fetch("message")
# first_message = parsed_message.fetch("content")
# pp first_message

# OR WITH FEWER LINES
# parsed_choice = api_response.fetch("choices").at(0).fetch("message").fetch("content")
# pp parsed_choice


# #Program Start
user_input = ""
while user_input.downcase != "bye"
  puts "Hello! How can I help you today?"
  puts "-" * 50
  user_input = gets.chomp

  if user_input != "bye"
  message_list << {"role" => "user", "content" => user_input}
  api_response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: message_list
    }
  )
  parsed_choice = api_response.fetch("choices").at(0).fetch("message").fetch("content")
  puts parsed_choice
  puts "-" * 50

  # Add the assistant's response to the message list
  message_list << { "role" => "assistant", "content" => parsed_choice }
  end
end
