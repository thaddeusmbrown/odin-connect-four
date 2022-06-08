require './lib/connect_four'

describe 'ConnectFour' do
  before(:each) do
    @main = ConnectFour.new
    @main.stub(:query_player)
    STDOUT.stub(:write)
    @main.stub(:place_tile).with(an_instance_of(Integer), an_instance_of(Integer))
  end
  describe '#place_tile' do
    it 'places a tile of the correct player in a non-empty column' do
      check_board = Array.new(6) { Array.new(7, ' ') }
      @main.instance_variable_set(:@game_board, check_board)
      check_board[0][0] = 'X'
      @main.instance_variable_set(:@player, 'X')
      @main.send(:place_tile, 0, 0)
      game_board = @main.instance_variable_get(:@game_board)
      expect(game_board).to eql(check_board)
    end
  end
  describe 'checking for victory' do
    before(:each) do
      @main = ConnectFour.new
    end
    it 'successfully finds a horizontal victory' do
      @main.instance_variable_set(:@game_board, [[0, 'X', 'X', 'X', 'X', 0, 0]] + Array.new(5) { Array.new(7, 0) } )
      result = @main.send(:check_victory)
      expect(result).to eql(1)
    end
    it 'successfully finds a vertical victory' do
      @main.instance_variable_set(:@game_board, Array.new(4, ['X'] + Array.new(6, 0)) + Array.new(3, Array.new(7, 0)))
      result = @main.send(:check_victory)
      expect(result).to eql(1)
    end
    xit 'successfully finds a forward diagonal victory' do
      check_board = [
        ['X', 0, 0, 0, 0, 0, 0],
        [0, 'X', 0, 0, 0, 0, 0],
        [0, 0, 'X', 0, 0, 0, 0],
        [0, 0, 0, 'X', 0, 0, 0]
      ] + Array.new(3, Array.new(7, 0))
      result = @main.check_victory
      expect(result).to eql(1)
    end
    xit 'successfully finds a backward diagonal victory' do
      check_board = [
        [0, 0, 0, 'X', 0, 0, 0],
        [0, 0, 'X', 0, 0, 0, 0],
        [0, 'X', 0, 0, 0, 0, 0],
        ['X', 0, 0, 0, 0, 0, 0]
      ] + Array.new(3, Array.new(7, 0))
      result = @main.check_victory
      expect(result).to eql(1)
    end
  end
end
