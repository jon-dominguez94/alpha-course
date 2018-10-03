class RPNCalculator

  def initialize
    @stack = []
  end

  def value
    @stack.last
  end

  def push(num)
    @stack.push(num)
  end

  def empty?
    @stack.length < 2
  end

  def plus
    raise "calculator is empty" if empty?
    op2 = @stack.pop
    op1 = @stack.pop
    @stack.push(op1 + op2)
  end

  def minus
    raise "calculator is empty" if empty?
    op2 = @stack.pop
    op1 = @stack.pop
    @stack.push(op1 - op2)
  end

  def times
    raise "calculator is empty" if empty?
    op2 = @stack.pop
    op1 = @stack.pop
    @stack.push(op1 * op2)
  end

  def divide
    raise "calculator is empty" if empty?
    op2 = @stack.pop
    op1 = @stack.pop
    @stack.push(op1.to_f / op2)
  end

  def tokens(string)
    tokens = []
    operators = "+-*/"
    string.split.each do |ch|
      if operators.include?(ch)
        tokens << ch.to_sym
      else
        tokens << ch.to_i
      end
    end
    tokens
  end

  def evaluate(string)
    tokens = tokens(string)
    tokens.each do |tok|
      if tok.is_a? Fixnum
        self.push(tok)
      else
        perform(tok)
      end
    end
    value
  end

  private

  def perform(token)
    case token
    when :+
      plus
    when :-
      minus
    when :*
      times
    when :/
      divide
    end
  end
end
