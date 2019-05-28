require 'pry'
class Word < ApplicationRecord
  belongs_to :user
  has_many :word_feelings
  has_many :feelings, through: :word_feelings
  accepts_nested_attributes_for :word_feelings
  validates_uniqueness_of :entry, :message=>"that word already exists"
  scope :most_recent, -> (limit) { order("created_at desc").limit(limit) }

  def self.find_most_loaded_words_idx(words)
    #@topwords = words.collect{|x| WordFeeling.where(word_id: x.id).average(:feeling_rating)}
    ##returns 10 most loaded words
    @avgs = []
    if words
      words.each do |w|
        myword = WordFeeling.where(word_id: w.id)
        @avgs << myword.average(:feeling_rating)
      end
      @avgs.map.with_index.sort.map(&:last).reverse
    end
  end

end
