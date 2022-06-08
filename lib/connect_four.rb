require 'pry-byebug'

class ConnectFour
  attr_reader :game_board, :player_list, :player

  def initialize
    @game_board = Array.new(6) { Array.new(7, ' ') }
    @player_list = ['X', 'O']
    # query_player()
  end

  protected

  def query_player
    @player = @player_list[0]
    puts "\nPlayer #{@player}: Please choose a column from 1 to 7."
    begin
      answer = gets.chop.to_i - 1
    rescue StandardError
      puts "Sorry.  You chose an invalid character!  Choose a number from 1 to 7. Try again."
      query_player()
    else
      check_column(answer)
    end
  end

  def check_column(answer)
    # binding.pry
    begin
      raise unless answer.between?(0, 6)
    rescue StandardError
      puts "Sorry.  You have to choose a column between 1 and 7!  Try again."
      query_player()
    end
    check_row(answer)
  end

  def check_row(answer)
    @game_board.each_with_index do |row, index|
      if row[answer] == ' '
        place_tile(index, answer)
        if check_victory()
          exit(true)
        end
        @player_list[0], @player_list[1] = @player_list[1], @player_list[0]
        query_player()
      end
    end
    puts "Sorry.  You have to choose a column that isn't full! Try again."
    query_player()
  end

  def place_tile(row, column)
    @game_board[row][column] = @player
    display_board()
  end

  def check_victory
    @game_board.each do |row|
      counter = 0
      player = ''
      row.each do |cell|
        if cell == ' '
          counter = 0
          player = ''
        elsif counter.zero?
          counter = 1
          player = cell
        elsif cell == player
          counter += 1
          if counter == 4
            victory(player)
            return 1
          end
        else
          player = cell
          if player == ' '
            counter = 0
          else
            counter = 1
          end
        end
      end
    end
    columns = @game_board.transpose
    columns.each do |col|
      counter = 0
      player = ''
      col.each do |cell|
        if cell == ' '
          counter = 0
        elsif counter.zero?
          counter = 1
          player = cell
        elsif cell == player
          counter += 1
          if counter == 4
            victory(player)
            return 1
          end
        else
          player = ''
          counter = 0
        end
      end
    end
    @game_board.each_with_index do |row, i|
      if i > 3
        next
      end
      player = ''
      counter = 0
      row.each_with_index do |cell, j|
        if cell == ' '
          player = ''
          counter = 0
        elsif counter.zero?
          player = cell
          if @game_board[i + 1][j + 1] == player and @game_board[i + 2][j + 2] == player and @game_board[i + 3][j + 3] == player
            victory(player)
            return 1
          counter = 0
          player = ''
          end
        else
          counter = 0
        end
      end
    end
    reverse_board = @game_board.map { |row| row.reverse }
    reverse_board.each_with_index do |row, i|
      if i > 3
        next
      end
      player = ''
      counter = 0
      row.each_with_index do |cell, j|
        if cell == ' '
          player = ''
          counter = 0
        elsif counter.zero?
          player = cell
          if reverse_board[i + 1][j + 1] == player and reverse_board[i + 2][j + 2] == player and reverse_board[i + 3][j + 3] == player
            victory(player)
            return 1
          counter = 0
          player = ''
          end
        else
          counter = 0
        end
      end
    end
    return false
  end

  def victory(player)
    puts "Victory! Player #{player} wins!"
    return 1
  end

  def display_board()
    top_row = ''
    (1..7).each do |num|
      top_row += '| ' + num.to_s + ' '
    end
    puts top_row += '|'
    puts '-' * 29
    @game_board.reverse.each do |row|
      middle_row = ''
      row.each do |col|
        middle_row += "| #{col} "
      end
      middle_row += '|'
      puts middle_row
      puts '-' * 29
    end
  end
end
# ConnectFour.new
