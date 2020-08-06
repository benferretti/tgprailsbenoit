class Tag < ApplicationRecord
  has_many :gossips, through: :gossips_tags
end
