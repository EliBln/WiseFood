OpenAI.configure do |config|
  config.access_token = ENV.fetch("OPENAI_ACCESS_TOKEN")
  config.log_errors = true # Optional
  config.request_timeout = 240 # Optional
end
