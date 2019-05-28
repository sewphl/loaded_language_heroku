class Feeling < ApplicationRecord
  has_many :users, through: :words
  has_many :word_feelings
  has_many :words, through: :word_feelings


  def self.avg_feeling_idx(words,feeling)
    @ratings = []
    if words
      words.each do |w|
        myword = WordFeeling.where(word_id: w.id, feeling_id: feeling.id)
        @ratings << myword.average(:feeling_rating)
      end
      @ratings.map.with_index.sort.map(&:last).reverse
    end
  end

end
