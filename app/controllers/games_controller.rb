require "open-uri"
class GamesController < ApplicationController

  def increment_counter(pal)
  if session[:result].nil?
    session[:result] = 0
  end
  session[:result] += pal
end

  def new
    # session.clear
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split
    @words_include = words_include?(@word, @letters)
    @english_word = english_word?(@word)
    if @english_word
      @result = increment_counter(@word.size)
    end
  end

  def words_include?(word, letters)
    @word.chars.all? { |letter| word.count(letter) <= letters.count(letter)}
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json["found"]
  end
end
