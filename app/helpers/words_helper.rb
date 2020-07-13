module WordsHelper

  def create_day(word)
    word.created_at.strftime("%B %d, %Y")
  end

  def create_time(word)
    word.created_at.strftime("%I:%M %p")
  end

  def compute_avg(word,feeling)
    ##compute average FOR A SINGLE FEELING FOR A SINGLE WORD.
    myword = WordFeeling.where(word_id: word.id, feeling_id: feeling.id)
    myword.average(:feeling_rating).round(2)
  end

  def compute_median(word,feeling)
    ##find median FOR A SINGLE FEELING FOR A SINGLE WORD.
    myword = WordFeeling.where(word_id: word.id, feeling_id: feeling.id)
    rating_arr = myword.pluck(:feeling_rating)
    sorted = rating_arr.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end

  ##checks to see if current user has already ranked a word in db.
  def already_ranked?(word,user)
    WordFeeling.where(word_id: word.id, user_id: user.id).exists?
  end

  ##returns links for words starting with letter (see words index view <a> tag)
  def returnURLs(letter)
    @myErb = []
    @words_.select { |word| word.entry.upcase.start_with?(letter) }.each do |w|
      @myErb.push(link_to w.entry, @words_.find(w.id))
    end
    @myErb
  end

end
