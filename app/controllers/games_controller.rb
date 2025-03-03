class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    # @grid = params[:grid]
    url = "https://dictionary.lewagon.com/#{params[:word]}"
    word_serialized = URI.parse(url).read
    word_valid = JSON.parse(word_serialized)['found']
    is_valid = word_valid?(params[:word].upcase, params[:grid].upcase.split)
    if !is_valid
      @msg = "Sorry but <b>#{params[:word]}</b> can't be built out of #{params[:grid].split.join(', ')}"
    elsif !word_valid
      @msg = "Sorry but <b>#{params[:word].upcase}</b> does not seem to be a valid English word..."
    else
      @msg = "<b>Congratulations!</b> #{params[:word].upcase} is a valid English word!"
    end
  end

  private

  def word_valid?(word, grid)
    word.upcase.each_char do |char|
      index = grid.index(char)
      return false if index.nil?

      grid.delete_at(index)
    end
    true
  end
end
