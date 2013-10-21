# process_kill.rb
# Shows how to terminate processes programmatically

puts "initializing worker processes..."

pids = 5.times.map do |i|
  fork do
    trap("TERM") do
      puts "Worker#{i}: kill signal received...shutting down"
      exit
    end

    loop do
      puts "Worker#{i}: *crunches numbers*"
      sleep rand(1..3)
    end
  end
end

sleep 5
puts "killing worker processes..."
pids.each { |pid| Process.kill(:TERM, pid) }
