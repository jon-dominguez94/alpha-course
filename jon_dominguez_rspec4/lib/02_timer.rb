class Timer
  attr_accessor :seconds

  def initialize
    @seconds = 0
  end

  def time_string
    get_time_stamp(@seconds)
  end

  private

  def translate(time)
    time < 10 ? "0#{time}" : "#{time.to_s}"
  end

  def get_time_stamp(seconds)
    hours = translate(seconds / 3600)
    minutes = translate((seconds % 3600) / 60)
    seconds = translate(seconds % 60)
    "#{hours}:#{minutes}:#{seconds}"
  end
end
