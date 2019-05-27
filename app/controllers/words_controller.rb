require 'pry'
class WordsController < ApplicationController
include WordsHelper

  def index
    if logged_in?
      @user = current_user
    end
    @words_ = Word.all
    @top10 = Word.find_most_loaded_words(@words_)
    @recent_words = Word.most_recent(5)
  end

  def show
    @word = Word.find_by(id: params[:id])
    @feelings = Feeling.all
  end

  def new
    @word = Word.new(user_id: current_user.id)##
    @feelings = Feeling.all
  end

  def create
    user = current_user
    @word = Word.create(word_params)

    if !@word.errors.full_messages.empty?
      flash[:notice] = "That word is already in the database"
      redirect_to words_path
    else
      @word.update(word_params)
      @feelings = Feeling.all
      @feelings.each do |feel|
        WordFeeling.create(feeling_id: feel.id, word_id: @word.id, feeling_rating: params[feel.name][:feeling_rating].to_f)
      end
      redirect_to user_word_path(user, @word)
    end
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
    user = current_user
    @word = Word.find_by(id: params[:id])
    if !@word.errors.full_messages.empty?
      flash[:notice] = "That word is already in the database"
      redirect_to words_path
    end
    @word.update(word_params)
    redirect_to user_word_path(user, @word)
  end

  private

  def word_params
    params.require(:word).permit(:entry, :user_id, feeling_ids:[], word_feelings_attributes: [:id, :feeling_rating])
  end

end
