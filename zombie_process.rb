# zombie_process.rb
# creates a process that won't end on its own. 
# Terminate it in the console with: 
#   $ kill [whatever pid the zombie has]

fork do
  puts "Zombie: *comes out of grave*"
  puts "Zombie: rahhh...kill me with: $ kill #{$$}"
  loop do
    puts "Zombie (#{$$}): brains..."
    sleep 1
  end
end

puts "Main (#{$$}): finished"
