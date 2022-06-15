class SentryPayloadParseJob < BasePayloadParseJob
  MATCHER = /sentry.io/.freeze

  def message
    name = data["project_name"]
    event = data["message"]
    culprit = data["culprit"]
    url = data["url"]
    
    text = []
    text << "[#{name}]"
    text << event
    text << "; #{culprit}"
    text << "(#{url})"

    text.join(" ")
  end

  def body
    { "text": message }.to_json
  end
end
