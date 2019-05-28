require 'pry'
class FeelingsController < ApplicationController

  def index
    @feelings = Feeling.all
  end

  def show
    @feeling = Feeling.find(params[:id])
    @words = Word.all
    @feeling_idx = Feeling.avg_feeling_idx(@words,@feeling)
  end

  private

  def feeling_params
    params.require(:feeling).permit(:name, :definition)
  end

end
