require 'byebug'

class Board
  attr_accessor :grid

  def initialize(*args)
    if args.empty?
      @grid = Array.new(3){Array.new(3)}
    else
      @grid = args[0]
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end

  def place_mark(pos, mark)
    if empty?(pos)
      self[pos] = mark
      return true
    else
      puts "Position already taken! Try again!"
      return false
    end
  end

  def empty?(pos)
    self[pos] == nil
  end

  def winner

    @grid.each do |row|
      return row[0] if (row.none? {|el| el == nil}) && row.uniq.length == 1
    end

    diag = []
    @grid.each_index {|i| diag << self[[i,i]]}
    return diag[0] if (diag.none? {|el| el == nil}) && diag.uniq.length == 1

    diag = []
    @grid.each_index do |i|
      j = (@grid.length - 1) - i
      diag << self[[i,j]]
    end
    return diag[0] if (diag.none? {|el| el == nil}) && diag.uniq.length == 1

    @grid.each_index do |j|
      col = []
      @grid.each_index {|i| col << self[[i,j]]}
      return col[0] if (col.none? {|el| el == nil}) && col.uniq.length == 1
    end

    nil

  end

  def over?
    if winner
      return true
    else
      return false if @grid.any? do |row|
        row.any? {|el| el == nil}
      end
      true
    end
  end

  def display
    underline = "-"*(@grid.length*3 + @grid.length - 1)
    @grid.each_with_index do |row,i|
      row_string = ""
      row.each do |el|
        if el
          row_string += " #{el} |"
        else
          row_string += "   |"
        end
      end
      puts row_string[0...-1]
      unless i == @grid.length - 1
        puts underline
      end
    end
  end

end
