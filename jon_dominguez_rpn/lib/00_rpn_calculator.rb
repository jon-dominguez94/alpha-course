class RPNCalculator
  # TODO: your code goes here!

  def initialize
    @stack = []
  end

  def push(num)
    @stack.push(num)
  end

  def value
    @stack.last
  end

  def plus
    if @stack.length < 2
      raise "calculator is empty"
    else
      op2 = @stack.pop
      op1 = @stack.pop
      @stack.push(op1 + op2)
    end
  end

  def minus
    if @stack.length < 2
      raise "calculator is empty"
    else
      op2 = @stack.pop
      op1 = @stack.pop
      @stack.push(op1 - op2)
    end
  end

  def divide
    if @stack.length < 2
      raise "calculator is empty"
    else
      op2 = @stack.pop
      op1 = @stack.pop
      @stack.push(op1.to_f / op2.to_f)
    end
  end

  def times
    if @stack.length < 2
      raise "calculator is empty"
    else
      op2 = @stack.pop
      op1 = @stack.pop
      @stack.push(op1.to_f * op2.to_f)
    end
  end

  def tokens(string)
    string.split.map! do |el|
      if el =~ /\d/
        el.to_i
      else
        el.to_sym
      end
    end
  end

  def evaluate(string)
    ops = [:+, :-, :*, :/]
    toks = tokens(string)
    toks.each do |t|
      if ops.include?(t)
        case t
        when :+
          self.plus
        when :-
          self.minus
        when :*
          self.times
        when :/
          self.divide
        end
      elsif t.is_a? Integer
        self.push(t)
      end
    end
    @stack.pop
  end

end
