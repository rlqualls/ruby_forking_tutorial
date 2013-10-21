# pid.rb
# Shows different ways of getting pids for parent and child processes

fork_pid = fork do
  puts "child: my pid is #{$$}"
  puts "child: my parent's pid is #{Process.ppid}"
end

puts "parent: my pid is #{Process.pid}"
puts "parent: my child's pid is #{fork_pid}"
