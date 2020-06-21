class Feeling < ApplicationRecord
  has_many :word_feelings
  has_many :words, through: :word_feelings
  has_many :users, through: :words

  ##given an array of words and a feeling,
  ##return an array of word IDs (not indices) for the words,
  ##ordered by highest to lowest average rating of that feeling.
  def self.avg_word_feeling_ids(words,feeling)
    @ratings = []
    @word_ids_sorted = []
    if words
      words.each do |w|
        ##collect all ratings for this feeling for this word
        mywords = WordFeeling.where(word_id: w.id, feeling_id: feeling.id)
        ##find avg rating for that feeling, add to array
        @ratings << mywords.average(:feeling_rating)
      end
      ##sort array of average ratings from highest to lowest
      @ratings_sorted = @ratings.map.with_index.sort.map(&:last).reverse
      ##words array, sorted by high to low average rating for that feeling.
      @words_sorted = @ratings_sorted.map { |index| words[index] }
      ##return just the word IDs of sorted words array:
      @words_sorted.each do |w|
        @word_ids_sorted << w.id
      end
      @word_ids_sorted
    end
  end

end
