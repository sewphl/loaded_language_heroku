class WordFeeling < ApplicationRecord
  has_many :words
  has_many :feelings
end
