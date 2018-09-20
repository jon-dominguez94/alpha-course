class ComputerPlayer

  attr_reader :name

  def initialize(name="CPU")
    @name = name
    @tries = []
  end

  def get_play
    # only choose from untried spots. Sample may stall program
    vals  = (0...10).to_a
    open_spots = []
    pos = []
    vals.each_index do |i|
      vals.each_index do |j|
        pos = [i,j]
        if !@tries.include?(pos)
          open_spots << pos
        end
      end
    end
    pos = open_spots.sample
    @tries << pos
    pos
  end

end
