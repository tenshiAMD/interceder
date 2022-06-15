class UpdownPayloadParseJob < BasePayloadParseJob
  MATCHER = /updown.io/.freeze

  def message
    name = data["check"]["name"] || data["check"]["url"]
    event = data["event"]["down"] ? "DOWN" : "UP"
    started_at = Time.zone.parse(data["downtime"]["started_at"]).strftime("%H:%M:%S")
    reason = data["downtime"]["error"]
    url = "https://updown.io/#{data["check"]["token"]}"

    parts = []

    case event
    when "DOWN"
      parts << "since #{started_at} (AWST)"
    when "UP"
      ended_at = Time.zone.parse(data["downtime"]["ended_at"]).strftime("%H:%M:%S")
      duration = distance_of_time_in_words(data["downtime"]["duration"])

      parts << "since #{ended_at} (AWST)"
      parts << "after being down for #{duration}"
    end

    parts << "reason: #{reason}"

    text = []
    text << "[#{name}]"
    text << event
    text << parts.join(", ")
    text << "(Status page: #{url})"

    text.join(" ")
  end

  def body
    { "text": message }.to_json
  end
end
