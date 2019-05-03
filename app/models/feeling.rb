class Feeling < ApplicationRecord
  has_many :users, through: :words
  has_many :word_feelings
  has_many :words, through: :word_feelings
end
