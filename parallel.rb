# parallel.rb
# Parallel iterates across collections with processes or threads
# Installation: 
#   $ gem install parallel

require 'parallel'

def calculate(magnitude)
  x = 0
  cycles = 10 ** magnitude
  cycles.times do
    x += 1.000001
  end
  return x
end

results = Parallel.map([6, 6, 6, 6, 7, 7, 7, 7]) do |mag|
  calculate(mag)
end

puts results
