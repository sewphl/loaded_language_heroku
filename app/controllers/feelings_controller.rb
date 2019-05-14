require 'pry'
class FeelingsController < ApplicationController

  def index
    @feelings = Feeling.all
  end

  def show
    @feeling = Feeling.find(params[:id])
  end

  private

  def feeling_params
    params.require(:feeling).permit(:name, :definition)
  end

end
