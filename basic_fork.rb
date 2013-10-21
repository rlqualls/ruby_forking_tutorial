# basic_fork.rb
# A fork inherits the terminal of its parent process

fork do
  sleep 2
  puts "Fork: finished"
end

puts "Main: finished"
