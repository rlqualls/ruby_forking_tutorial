# forkable.rb
# A module that lets you fork a method and get its result in a block
# Notes: 
#   1. Forked methods can't take blocks in this implementation
#   2. Call back threads will be destroyed if the main process exits
#   3. Not production ready. For educational purposes only.
####################################################################

# If included in a class #fork_method will run a method in another process
# and yield the result to a block
module Forkable
  def fork_method(method, *args)
    reader, writer = IO.pipe
    fork do
      reader.close
      result = self.send(method, *args)
      child_data = Marshal.dump(result)
      writer.puts(child_data)
    end

    writer.close
    Thread.new do
      data_from_child = reader.gets
      yield Marshal.load(data_from_child) if block_given?
    end
  end
end

# An object that takes a random amount of time to instantiate
class ExpensiveObject
  
  attr_reader :expense
  
  def initialize(max_expense)
    @expense = rand(1..max_expense)
    sleep @expense
  end
end

# A worker that forks, a...forker
class Forker
  include Forkable

  def calculate(max_expense)
    return ExpensiveObject.new(max_expense)
  end
end

# Create 3 ExpensiveObjects and print how long they took to create
f = Forker.new
3.times do 
  f.fork_method(:calculate, 7) do |result|
    puts "result: #{result.inspect}"
  end
end

puts "waiting on results..."

Process.waitall
puts "main process finished"
