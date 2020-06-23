class User < ApplicationRecord
  include ActiveModel::SecurePassword
  has_secure_password
  validates_uniqueness_of :username, :message=>"that username already exists"
  validates_uniqueness_of :email, :message=>"that email address already exists"
  validates :username, :first_name, :email, :password,
    :presence => {:message=>"please fill out all fields"}
  has_many :words
  has_many :word_feelings
  has_many :feelings, through: :word_feelings
  accepts_nested_attributes_for :words
  validates :password, length: { minimum: 8 }, allow_nil: true
  scope :top_user, -> {User.joins(:words).group("users.id").order("count(users.id) DESC").limit(1).take}

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
        user.password = user.password_confirmation = user.password_digest =  SecureRandom.urlsafe_base64(n=6)
        user.provider = auth.provider
        user.uid = auth.uid
        user.first_name = auth.info.first_name
        user.email = auth.info.email
        user.username = auth.info.name
        user.save!
      end
    end
end
