class Timer
  attr_accessor :seconds

  def initialize
    @seconds = 0
  end

  def time_string
    time_sections = get_time_sections(@seconds)
    translate(time_sections)
  end

  private

  def translate(time)
    time_str = ""
    time.each_with_index do |el, i|
      time_str += el < 10 ? "0#{el}" : "#{el.to_s}"
      time_str += ":" if i < time.length - 1
    end
    time_str
  end

  def get_time_sections(seconds)
    hours = seconds / 3600
    minutes = (seconds % 3600) / 60
    seconds = seconds % 60
    [hours, minutes, seconds]
  end
end
