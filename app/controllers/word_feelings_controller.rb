class WordFeelingsController < ApplicationController

  def new
    user = current_user
    @word = Word.find_by(id: params[:word_id])
    @feelings = Feeling.all##
    @word_feelings = WordFeeling.all
    @feelings.each do |feel|
        WordFeeling.new()
    end
  end

  def create
    user = current_user
    @word = Word.find_by(id: params[:word_id])
    @feelings = Feeling.all
    @word_feelings = WordFeeling.all
    @feelings.each do |feel|
      WordFeeling.create(word_id: @word.id, user_id: user.id, feeling_id: feel.id, feeling_rating: params[feel.name][:feeling_rating].to_f)
    end
    redirect_to words_path
  end

  private

end
