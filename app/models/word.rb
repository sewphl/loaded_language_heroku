class Word < ApplicationRecord
  belongs_to :user
  has_many :word_feelings
  has_many :feelings, through: :word_feelings
  accepts_nested_attributes_for :word_feelings
  validates_uniqueness_of :entry, :message=>"that word already exists"
end
