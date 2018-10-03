class Student

  attr_accessor :first_name, :last_name, :courses

  def initialize (fname, lname)
    @first_name = fname
    @last_name = lname
    @courses = []
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def enroll(course)
    if !@courses.include?(course)
      raise "Course conflict" if @courses.any? {|c| c.conflicts_with?(course)}
      @courses.push(course)
      course.students.push(self)
    end
  end

  def course_load
    c_load = Hash.new(0)
    @courses.each {|course| c_load[course.department] += course.credits}
    c_load
  end

end
