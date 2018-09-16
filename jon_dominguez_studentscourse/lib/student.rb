class Student

  attr_accessor :first_name, :last_name, :courses

  def initialize(fname, lname)
    @first_name = fname
    @last_name = lname
    @courses = []
    "#{@first_name} #{@last_name}"
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def has_conflict?(course2)
    @courses.any? {|course| course.conflicts_with?(course2)}
  end

  def enroll(course)
    raise "Course conflicts with enrolled course" if has_conflict?(course)
    if (!@courses.include?(course)) && (!course.students.include?(self))
      @courses << course
      course.students << self
    end
  end

  def course_load
    result = Hash.new(0)
    @courses.each {|course| result[course.department] += course.credits}
    result
  end

end
