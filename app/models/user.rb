class User < ApplicationRecord

  has_many :orders

  has_secure_password

  # mount_uploader :image, ImageUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}
  validates :username, presence: true, uniqueness: true

  # extend FriendlyId
  # friendly_id :username, use: [:slugged, :history]
  #
  # before_save :update_slug
  #
  # private
  #
  # def update_slug
  #   if username
  #     self.slug = username.gsub(" ", "-")
  #   end
  # end
  #
end
