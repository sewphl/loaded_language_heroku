class WordFeeling < ApplicationRecord
  belongs_to :words
  belongs_to :feelings
end
