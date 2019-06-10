class User < ApplicationRecord
  include ActiveModel::SecurePassword
  has_secure_password
  validates_uniqueness_of :username, :message=>"that username already exists"
  validates_uniqueness_of :email, :message=>"that email address already exists"
  validates :username, :first_name, :email, :password,
    :presence => {:message=>"please fill out all fields"}
  has_many :words
  has_many :feelings, through: :words
  accepts_nested_attributes_for :words
  validates :password, length: { minimum: 8 }, allow_nil: true


  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
        user.password = user.password_confirmation = user.password_digest =  SecureRandom.urlsafe_base64(n=6)
        user.provider = auth.provider
        user.uid = auth.uid
        user.first_name = auth.info.first_name
        user.email = auth.info.email
        user.username = auth.info.name
        #user.oauth_token = auth.credentials.token
        #user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.save!
      end
    end
end
