class Integration < ApplicationRecord
  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(32)

  validates :name, presence: true

  validates :name, uniqueness: true
end
