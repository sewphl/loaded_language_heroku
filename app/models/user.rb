class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates :username, :first_name, :email, :password, :presence => true
  has_many :words
  has_many :feelings, through: :words
  accepts_nested_attributes_for :words

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
