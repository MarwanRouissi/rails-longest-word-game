class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    # @grid = params[:grid]
    url = "https://dictionary.lewagon.com/#{params[:word]}"
    word_serialized = URI.parse(url).read
    word_valid = JSON.parse(word_serialized)['found']
    if !word_valid
      @msg = "Sorry but <b>#{params[:word]}</b> does not seem to be a valid English word..."
    elsif !word_valid?(params[:word], params[:grid].split)
      @msg = "Sorry but <b>#{params[:word]}</b> can't be built out of #{params[:grid]}"
    else
      @msg = "<b>Congratulations!</b> #{params[:word]} is a valid English word!"
    end
  end

  def word_valid?(word, grid)
    word.upcase.each_char do |char|
      index = grid.index(char)
      return false if index.nil?

      grid.delete_at(index)
    end
    true
  end
end
