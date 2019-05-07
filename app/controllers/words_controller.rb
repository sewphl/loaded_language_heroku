class WordsController < ApplicationController

  def index
    @words = Word.all
  end

  def show
    @word = Word.find_by(id: params[:id])
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.create(word_params)
    redirect_to @word
  end

  def edit
    @word = Word.find_by(id: params[:id])
  end

  def update
    @word = Word.find_by(id: params[:id])
    @word.update(word_params)
    redirect_to @word
  end

  private

  def word_params
    params.require(:word).permit(:entry, :loaded_entry)
  end

end
