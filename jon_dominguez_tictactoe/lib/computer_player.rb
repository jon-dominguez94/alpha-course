class ComputerPlayer

  attr_accessor :board, :mark

  def initialize(name)
    @name = name
  end

  def display(board)
    @board = board
  end

  def random_move
=begin
    # could get stuck in loop for a long time if it keeps generating same randoms
    loop do
      row = rand(@board.grid.length - 1)
      col = rand(@board.grid.length - 1)
      return [row,col] if !@board[[row,col]]
    end
=end
    open_spots = []
    @board.grid.each_with_index do |row, i|
      row.each_index do |j|
        pos = [i,j]
        open_spots << pos if @board.empty?(pos)
      end
    end
    open_spots.sample
  end

  def win_move
    @board.grid.each_with_index do |row, i|
      row.each_index do |j|
        pos = [i,j]
        next if !@board.empty?(pos)
        @board.place_mark(pos, @mark)
        if @board.winner
          @board[pos] = nil
          return pos
        else
          @board[pos] = nil
        end
      end
    end
    false
  end

  def get_move
    win_move || random_move
  end
end
