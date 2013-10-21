# distributed.rb
# Creates several worker processes and concurrently waits for the fastest one

require 'drb'

NUM_WORKERS = 4

class Worker

  def calculate
    time_to_work = rand(1..7)
    sleep time_to_work
    return time_to_work
  end

  def stop
    DRb.stop_service
  end
end

# Start object services
NUM_WORKERS.times do |i|
  DRb.start_service("druby://:700#{i}", Worker.new)
  puts "Worker running at #{DRb.uri}"
end

# Create a local end-point for each service
workers = NUM_WORKERS.times.map { |i| DRbObject.new nil, "druby://:700#{i}" }

# Concurrently wait for the fastest calculation
thread_pool = []
NUM_WORKERS.times do |i|
  thread_pool << Thread.new do
    answer = workers[i].calculate
    puts "Worker #{i} finished in #{answer} seconds"
  end
end

# Wait for every thread to get its answer
thread_pool.each(&:join)

# Shut down each worker
workers.each { |w| w.stop }
