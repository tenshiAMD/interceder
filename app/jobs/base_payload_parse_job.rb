class BasePayloadParseJob < ApplicationJob
  include ActionView::Helpers::DateHelper

  MATCHER = //.freeze

  attr_accessor :data

  def perform(payload)
    return unless payload.body.match?(MATCHER)

    @data = payload.data

    payload.response = send_request(payload.target_links, body: body)
    payload.save
  end

  private
    def send_request(links = [], *options)
      args = options.extract_options!
      
      request_body = args[:body]
      request_headers = args[:headers] || { 'Content-Type' => 'application/json' }

      responses = []

      links.each do |link|
        begin
          uri = URI.parse(link)

          connection = Net::HTTP.new(uri.host, uri.port)
          connection.use_ssl = true
    
          request = Net::HTTP::Post.new(uri.request_uri, request_headers)
          request.body = request_body

          response = connection.request(request)
    
          responses << response.body
        rescue => exception
          next
        end
      end

      responses
    end
end
