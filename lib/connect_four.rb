require 'pry-byebug'

class ConnectFour
  attr_reader :game_board, :player_list

  def initialize
    @player_list = []
  end

  def new_game

  end

  def place_tile(column, player)

  end

  def check_victory

  end
end


check_board = [
  ['X', 0, 0, 0, 0, 0, 0],
  [0, 'X', 0, 0, 0, 0, 0],
  [0, 0, 'X', 0, 0, 0, 0],
  [0, 0, 0, 'X', 0, 0, 0]
] + Array.new(3, Array.new(7, 0))

p check_board