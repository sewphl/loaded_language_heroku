class Word < ApplicationRecord
  belongs_to :user
  has_many :word_feelings
  has_many :feelings, through: :word_feelings
  accepts_nested_attributes_for :word_feelings
  validates_uniqueness_of :entry, :message=>"that word already exists"

  def compute_avg(word,feeling=nil)
    if feeling !=nil
      ##compute average OF ALL FEELINGS FOR A SINGLE WORD.
      myword = WordFeeling.where(word_id: word.id, feeling_id: feeling.id)
    else
      ##compute average FOR A SINGLE FEELING FOR A SINGLE WORD.
      myword = WordFeeling.where(word_id: word.id)
    end
    myword.average(:feeling_rating).round(2)
  end

  def self.find_most_loaded_words
    ##returns 10 most loaded words
    @words = Word.all
    @avgs = []
    @words.each do |w|
      myword = WordFeeling.where(word_id: w.id)
      @avgs << myword.average(:feeling_rating)
    end
    @top10 = @words.sort_by{|x| @avgs.index x.id}.first 10
    @top10.each do |t|
      puts(t.entry + ": " + compute_avg(t).to_s)
    end
  end

end
