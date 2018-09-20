class HumanPlayer

  attr_reader :name

  def initialize(name="Jon")
    @name = name
    @rows = ("A".."J").to_a
    @cols = (1..10).to_a
  end

  def get_play
    puts "Please enter a valid location on the board. Ex: A 10"
    ans = gets.chomp.split
    row = ans[0].upcase
    col = ans[1].to_i
    pos = convert(row, col)
  end

  def convert(row, col)
    r_idx = @rows.index(row)
    c_idx = @cols.index(col)
    [r_idx, c_idx]
  end

end
