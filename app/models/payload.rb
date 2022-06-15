class Payload < ApplicationRecord
  include ActionView::Helpers::DateHelper

  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(32)

  serialize :response, Array

  belongs_to :app, optional: false
  delegate :link, to: :app
  alias_attribute :target_links, :link

  validates :body, presence: true

  after_commit :parse_payload, on: %i[create]

  def data
    JSON.parse(body)
  end

  def parse_payload
    Integration.find_each do |record|
      klass = "#{record.name}PayloadParseJob".safe_constantize

      next if klass.blank?

      klass.perform_later(self) if body.match?(klass::MATCHER)
    end
  end
end
