require 'pry'
class WordsController < ApplicationController
include WordsHelper

def words_
  if current_user
    User.find(current_user.id).words
  end
end

  def index
    if logged_in?
      @user = current_user
      ##user-added words only!
      @userwords = words_ ##see words_ method above; specific to user
      @recent_words = @userwords.most_recent(5)
    end
    ##all words
    @words_ = Word.all
    @abcwords_ids = Word.alphabetize_words_ids(@words_)
  end

  def show
    @user = current_user
    @word = Word.find_by(id: params[:id])
    @feelings = Feeling.all
    @feels = []
    @avgs = []
    @medians = []
    Feeling.all.sort_by(&:name).each do |feel|
	     @feels << feel.name
       @avgs << compute_avg(@word,feel)
       @medians << compute_median(@word,feel)
    end
    @num_users = WordFeeling.where(word_id:@word.id).distinct.pluck(:user_id).length
  end

  def new
    @word = Word.new(user_id: current_user.id)##
    @feelings = Feeling.all
  end

  def create
    user = current_user
    @word = Word.new(word_params)
    @feelings = Feeling.all
    if @word.save
      @feelings.each do |feel|
        WordFeeling.create(user_id: params[:word][:user_id], feeling_id: feel.id, word_id: @word.id, feeling_rating: params[feel.name][:feeling_rating].to_f)
      end
      redirect_to user_word_path(user, @word)
    else
      render :new
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
