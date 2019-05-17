module WordsHelper

  def create_day(word)
    word.created_at.strftime("%B %d, %Y")
  end

  def create_time(word)
    word.created_at.strftime("%I:%M %p")
  end

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



end
