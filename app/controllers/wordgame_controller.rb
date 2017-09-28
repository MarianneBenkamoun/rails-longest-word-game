require 'open-uri'
require 'json'

class WordgameController < ApplicationController
  def score
    @attempt = params[:attempt]
    @grid = params[:grid].split('')
    @start_time = params[:start_time]
    if included?(@attempt.upcase, @grid)
      if english_word?(@attempt)
        @end_time = Time.now
        time_taken = @start_time.to_time - @end_time
        if time_taken > 60.0
          @score = 0
        else
          @score = @attempt.size * (1.0 - time_taken / 60.0)
        end
        # [score, "well done"]
      else
        @score = "it's not an english word"
      end
    else
      @score = "it's not in the grid"
    #not in the grid
  end
end


def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end

def included?(guess, grid)
  guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
end

def game

  @attempt = params[:attempt]

  grille = Array.new(10) { ('A'..'Z').to_a.sample }
  @grid = grille.join("")
  @start_time = Time.now.to_formatted_s(:long)
end
end




