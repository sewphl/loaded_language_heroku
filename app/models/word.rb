require 'pry'
class Word < ApplicationRecord
  belongs_to :user
  has_many :word_feelings
  has_many :feelings, through: :word_feelings
  accepts_nested_attributes_for :word_feelings
  validates_uniqueness_of :entry, :message=>"that word already exists"
  scope :most_recent, -> (limit) { order("created_at desc").limit(limit) }

  def self.find_most_loaded_words(words)
    #@topwords = words.collect{|x| WordFeeling.where(word_id: x.id).average(:feeling_rating)}
    ##returns 10 most loaded words
    @avgs = []
    words.each do |w|
      myword = WordFeeling.where(word_id: w.id)
      @avgs << myword.average(:feeling_rating)
    end
    ##@topwords = words.sort_by{|x| @avgs.index x.id}#.first 10
    ##binding.pry
    words.sort_by do |element|
      @avgs.index(element)
    end
  end

end
