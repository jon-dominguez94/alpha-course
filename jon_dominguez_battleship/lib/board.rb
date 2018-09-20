require 'byebug'
class Board

  attr_accessor :grid

  def initialize(grid=Board.default_grid)
      @grid = grid
  end

  def self.default_grid
    Array.new(10){Array.new(10)}
  end

  def count
    count = 0
    @grid.each do |row|
      count += row.count(:s)
    end
    count
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end

  def no_ships?
    @grid.all? {|row| row.all? {|el| el == nil}}
  end

  def empty?(pos=[0,0])
    return true if no_ships? || self[pos] == nil
    return false if !no_ships?
  end

  def full?
    @grid.all? {|row| row.none? {|el| el == nil}}
  end

  def find_open_spots
    open_spots = []
    @grid.each_with_index do |row, i|
      row.each_index do |j|
        pos = [i, j]
        open_spots << pos if self.empty?(pos)
      end
    end
    open_spots
  end

  def place_random_ship
    #debugger
    raise "Board is full" if self.full?
    open_spots = self.find_open_spots
    pos = open_spots.sample
    self[pos] = :s
  end

  def won?
    @grid.all? {|row| row.all? {|el| el != :s}}
  end

  def in_range?(pos)
    row, col = pos
    return false if !(0...@grid.length).to_a.include?(row) ||
                    !(0...@grid[0].length).to_a.include?(col)
    true
  end

  def populate_grid(num)
    # moved size restrictions to battleship.rb
    # only populate with 5-(max/5) to prevent having too many ships
    #squares = @grid.length * @grid[0].length
    #ships = rand(squares/5) + 5
    num.times do
      begin
        place_random_ship
      rescue
        break
      end
    end
  end

  def display(flag=false)
    # display col labels
    nums = ("1".."26").to_a
    labels = "|   |"
    @grid[0].each_index do |i|
      curr = nums[i]
      labels += " #{curr}"
      labels += " "*(curr.length%2) + "|"
    end
    puts labels
    underline = "- "*(labels.length/2 + 1)
    puts underline
    # display row label, then row contents
    letters = ("A".."Z").to_a
    @grid.each_with_index do |row, i|
      contents = "| #{letters[i]} |"
      row.each do |el|
        val = el || " "
        #uncomment next line when finished
        if flag
          val = " " if val == :s
        end
        contents += " #{val} |"
      end
      puts contents
      puts underline
    end
  end

  def place_ships
    ships = {
      "Aircraft Carrier" => 5,
      "Battleship" => 4,
      "Submarine" => 3,
      "2nd Submarine" => 3,
      "Destroyer" => 3,
      "2nd Destroyer " => 3,
      "Patrol Boat" => 2,
      "2nd Patrol Boat" => 2,
      "3rd Patrol Boat" => 2,
    }
    ships.each do |k, v|
      loop do
        self.display
        puts "\n\nPlace your #{k}. It takes up #{v} tiles\n\n"
        options = []
        pos = get_pos
        if in_range?(pos)
          options << pos
          puts "Right(r) or Down(d)?"
          ans = gets.chomp.strip
          if ["r", "d"].include?(ans)
            options << ans
          else
            puts "Invalid response\n\n"
            next
          end
        else
          puts "Invalid location\n\n"
          next
        end
        if insert_ship(options[0], options[1], v)
          puts %x{clear}
          break
        else
          puts "Ship cannot be placed there! Try again\n\n"
        end
      end
    end
  end

  def insert_ship(pos, dir, size)
    positions = [pos]
    row, col = pos
    (size-1).times do
      if dir ==  "r"
        col += 1
      else
        row += 1
      end
      positions << [row, col]
    end
    positions.each do |curr|
      if !in_range?(curr) || self[curr] == :s
        return false
      end
    end
    positions.each {|curr| self[curr] = :s}
    return true
  end

  def get_pos
    puts "Choose a starting position. Ex: A 10"
    ans = gets.chomp.split
    row = ans[0].upcase
    col = ans[1].to_i
    pos = convert(row, col)
  end

  def convert(row, col)
    r_idx = ("A".."J").to_a.index(row)
    c_idx = (1..10).to_a.index(col)
    [r_idx, c_idx]
  end

end
