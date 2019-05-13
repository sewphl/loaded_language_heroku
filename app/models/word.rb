class Word < ApplicationRecord
  belongs_to :user
  has_many :word_feelings
  has_many :feelings, through: :word_feelings
  accepts_nested_attributes_for :word_feelings
  validates_uniqueness_of :entry, :message=>"that word already exists"

  def compute_avg(word,feeling=nil)
    if feeling !=nil
      ##compute average OF ALL FEELINGS FOR A SINGLE WORD.
      mywords = WordFeeling.where(word_id: word.id, feeling_id: feeling.id)
    else
      ##compute average FOR A SINGLE FEELING FOR A SINGLE WORD.
      mywords = WordFeeling.where(word_id: word.id)
    end
    mywords.average(:feeling_rating).round(2)
  end

end
