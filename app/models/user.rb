# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  enum :role, { admin: "admin", viewer: "viewer" }

  has_many :questions, dependent: :restrict_with_exception
  has_many :answers, dependent: :restrict_with_exception

  normalizes :email, with: ->(email) { email.to_s.strip.downcase }

  validates :email,
            presence: true,
            format: URI::MailTo::EMAIL_REGEXP,
            uniqueness: true

  def self.find_by(args)
    super || NullUser.new
  end

  def self.find(id)
    id ? super : NullUser.new
  end

  def logged_in?
    true
  end
end
