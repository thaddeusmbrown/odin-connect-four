require './lib/connect_four'

describe 'ConnectFour' do
  describe 'game start and basic functions' do
    before(:each) do
      @main = ConnectFour.new
      @main.stub(:new_game)
      @main.stub(:place_tile).with(an_instance_of(Integer), an_instance_of(String))
      @main.new_game
    end
    it 'creates an empty game board' do
      check_board = Array.new(6) { Array.new(7, 0) }
      game_board = @main.instance_variable_get(:@game_board)
      expect(game_board).to eql(check_board)
    end
    it 'places a tile of the correct player in a non-empty column' do
      check_board = Array.new(6) { Array.new(7, 0) }
      check_board[0][0] = 'X'
      @main.place_tile(0, 'X')
      game_board = @main.instance_variable_get(:@game_board)
      expect(game_board).to eql(check_board)
    end
    it 'raises an exception when the player tries to place a piece outside the gameboard' do
      @main.place_tile(-1, 'X')
      expect { @main.place_tile(-1, 'X') }
        .to raise_exception StandardError
    end
    it 'raises an exception when the player tries to place a piece in a full column' do
      full_board = Array.new(6) { Array.new(7, 'X') }
      expect { @main.place_tile(0, 'X') }
        .to raise_exception StandardError
    end
    it 'changes the current player after each turn' do
      @main.place_tile(0, 'X')
      next_player = @main.player_list[0]
      expect(next_player).to eql('O')
    end
  end
  describe 'checking for victory' do
    before(:each) do
      @main = ConnectFour.new
      @main.stub(:check_victory)
    end
    it 'successfully finds a horizontal victory' do
      check_board = check_board = [[0, 'X', 'X', 'X', 'X', 0, 0]] + Array.new(5) { Array.new(7, 0) }
      result = @main.check_victory
      expect(result).to eql(true)
    end
    it 'successfully finds a vertical victory' do
      check_board = Array.new(4, ['X'] + Array.new(6, 0)) + Array.new(3, Array.new(7, 0))
      result = @main.check_victory
      expect(result).to eql(true)
    end
    it 'successfully finds a forward diagonal victory' do
      check_board = [
        ['X', 0, 0, 0, 0, 0, 0],
        [0, 'X', 0, 0, 0, 0, 0],
        [0, 0, 'X', 0, 0, 0, 0],
        [0, 0, 0, 'X', 0, 0, 0]
      ] + Array.new(3, Array.new(7, 0))
      result = @main.check_victory
      expect(result).to eql(true)
    end
    it 'successfully finds a backward diagonal victory' do
      check_board = [
        [0, 0, 0, 'X', 0, 0, 0],
        [0, 0, 'X', 0, 0, 0, 0],
        [0, 'X', 0, 0, 0, 0, 0],
        ['X', 0, 0, 0, 0, 0, 0]
      ] + Array.new(3, Array.new(7, 0))
      result = @main.check_victory
      expect(result).to eql(true)
    end
  end
end
