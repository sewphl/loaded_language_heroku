class WordsController < ApplicationController

  def index

    @words = Word.all
  end

  def show
    @word = Word.find_by(id: params[:id])
  end

  def new
    @word = Word.new(user_id: params[:user_id])
  end

  def create
    @word = Word.create(word_params)
    redirect_to @word
  end

  def edit
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user.nil?
        redirect_to users_path, alert: "User not found."
      else
        @word = user.words.find_by(id: params[:id])
        redirect_to user_words_path(user), alert: "Word not found." if @word.nil?
      end
    else
      @word = Word.find(params[:id])
    end
  end

  def update
    @word = Word.find_by(id: params[:id])
    @word.update(word_params)
    redirect_to @word
  end

  private

  def word_params
    params.require(:word).permit(:entry, :loaded_entry, :user_id)
  end

end
