# shared_memory.rb
# Forks have access to objects created before the fork

data = [1,2,3]

fork do
  puts "data in child: #{data}"
end

puts "data in parent: #{data}"
