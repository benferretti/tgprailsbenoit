class Gossip < ApplicationRecord
  belongs_to :user
  has_many :tags, through: :gossips_tags
  has_many :comments
  validates :title, presence: true, length: {minimum: 3, maximum: 50, message: "Votre titre doit être compris entre 3 et 50 caractères" } 
  validates :content, presence: true
end
