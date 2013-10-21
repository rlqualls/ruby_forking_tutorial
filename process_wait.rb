# process_wait.rb
# Sometimes it's useful to wait until all processes have finished

fork do
  3.times do
    puts "Zombie: brains..."
    sleep 1
  end
  puts "Zombie: blehhh *dies*"
end

Process.waitall

puts "Main: finished"
