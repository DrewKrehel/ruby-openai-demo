require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPEN_AI_KEY"))

#pp client

# Prepare an Array of previous messages
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
api_response = client.chat(
  parameters: {
    model: "gpt-3.5-turbo",
    messages: message_list
  }
)

#pp api_response
parsed_choice = api_response.fetch("choices")
choice_result = parsed_choice.at(0)
parsed_message = choice_result.fetch("message")
first_message = parsed_message.fetch("content")

#Program Start
puts "Hello! How can I help you today?"
puts 50*"-"
user_input = gets.chomp
message_list << user_input
