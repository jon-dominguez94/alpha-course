def pad(num)
  result = num.to_s
  result = "0" + result if result.length == 1
  result
end

class Timer
  # TODO: your code goes here!
  attr_accessor :seconds
  attr_reader :time_string

  def initialize
    @seconds = 0
    @time_string = "00:00:00"
  end

  def seconds=(num)
    @seconds = num
    hours = pad(num / 3600)
    minutes = pad((num % 3600)/60)
    seconds = pad(num % 60)
    @time_string = "#{hours}:#{minutes}:#{seconds}"
  end
end
