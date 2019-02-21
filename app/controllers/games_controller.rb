require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    8.times do
      @letters << ('A'..'Z').to_a.sample(1)
    end
    @letters
  end

  def score
    grid = @letters
    @user_input = params[:input]
    word_bank = dictionary(@user_input)
    a = word_bank['word'].upcase.chars
    if word_bank['found'] == true && a.all? { |c| a.count(c) }
      @score = word_bank['length'].to_i
      @message = "Well done #{@user_input.capitalize} exists !"
    elsif word_bank['found'] == false
      @score = 0
      @message = 'Not an english word!'
    else
      @score = 0
      @message = 'The given word does not correspond to the letters given'
    end
  end

  def dictionary(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    JSON.parse(open(url).read)
  end
end
