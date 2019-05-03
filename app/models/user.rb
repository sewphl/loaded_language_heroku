class User < ApplicationRecord
  has_many :words
  has_many :feelings, through: :words
end
