class User < ApplicationRecord
  belongs_to :city, optional: true
  has_many :comments
  has_many :gossips
  has_many :sent_messages, foreign_key: 'sender_id', class_name: "CreatePrivateMessage"
  has_many :received_messages, foreign_key: 'recipient_id', class_name: "CreatePrivateMessage"
  has_secure_password
  
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+.)+[^@\s]+\z/, message: "email adress please" } 
  validates :age, presence: true
end
