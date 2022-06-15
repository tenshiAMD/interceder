class App < ApplicationRecord
  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(32)

  serialize :link, Array

  has_many :payloads, dependent: :destroy

  validates :name, :link, presence: true

  validates :name, uniqueness: { scope: %i[link] }
end
