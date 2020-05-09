require 'pry'
class Word < ApplicationRecord
  belongs_to :user
  has_many :word_feelings
  has_many :feelings, through: :word_feelings
  accepts_nested_attributes_for :word_feelings
  validates_uniqueness_of :entry, :message=>"that word already exists"
  scope :most_recent, -> (limit) { order("created_at desc").limit(limit) }

  ##return the IDs (not indices) of an array of words,
  ##from most 'loaded' to least 'loaded'
  ##(based on average of all loaded ratings)
  def self.find_most_loaded_words_ids(words)
    @avgs = []
    @word_ids_sorted = []
    if words
      words.each do |w|
        myword = WordFeeling.where(word_id: w.id)
        @avgs << myword.average(:feeling_rating)
      end
      ##array of indices of words array,
      ##from highest to lowest avg loaded-ness
      @avgs_sorted = @avgs.map.with_index.sort.map(&:last).reverse
      ##words array, sorted by high to low loaded-ness:
      @words_sorted = @avgs_sorted.map { |index| words[index] }
      ##return just the word IDs of sorted words array:
      @words_sorted.each do |w|
        @word_ids_sorted << w.id
      end
      @word_ids_sorted
    end
  end

  ##return word IDs (not indices) of array of words
  ##after sorting alphabetically.
  def self.alphabetize_words_ids(words)
    @word_ids_abc = []
    ##indices of words array after sorting alphabetically:
    @indices = words.pluck(:entry).map.with_index.sort_by{|x| x.first.downcase}.map(&:last)
    ##words array, sorted alphabetically:
    @words_abc = @indices.map { |index| words[index] }
    ##return just the word IDs of abc-sorted words array:
    @words_abc.each do |w|
      @word_ids_abc << w.id
    end
    @word_ids_abc
  end

end
