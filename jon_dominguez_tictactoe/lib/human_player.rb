class HumanPlayer
  attr_accessor :name, :mark

  def initialize(name)
    @name = name
  end

  def get_move
    result = []
    loop do
      puts "Where do you want to place your mark?"
      puts "Choose a row and column 0-2. Ex: 0, 1"
      ans = gets.chomp
      result = ans.split(',').map {|num| num.to_i}
      valids = [0, 1, 2]
      break if result.length == 2 && result.all? {|num| valids.include?(num)}
      puts "Invalid option! Try again!"
    end
    result
  end

  def display(board)
=begin
    underline = "-"*(board.grid.length*2 + board.grid.length - 1)
    board.grid.each_with_index do |row,i|
      row_string = ""
      row.each do |el|
        if el
          row_string += "#{el}|"
        else
          row_string += "  |"
        end
      end
      puts row_string[0...-1]
      unless i == board.grid.length - 1
        puts underline
      end
    end
=end
    board.display
  end

end
