require 'pry'
class FeelingsController < ApplicationController

  def index
    @feelings = Feeling.all
  end

  def show
    @feeling = Feeling.find(params[:id])
    @words = Word.all
    @word_feeling_ids = Feeling.avg_word_feeling_ids(@words,@feeling)
  end

  private

  def feeling_params
    params.require(:feeling).permit(:name, :definition)
  end

end
