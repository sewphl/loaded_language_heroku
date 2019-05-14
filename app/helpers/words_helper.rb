module WordsHelper
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

  def find_most_loaded_words
    ##returns 10 most loaded words
    @words = Word.all
    @avgs = []
    @words.each do |w|
      myword = WordFeeling.where(word_id: w.id)
      @avgs << myword.average(:feeling_rating)
    end
    @words.sort_by{|x| @avgs.index x.id}.first 10
  end
end
