# child_parent_pipe.rb
# creates a fork and pipes a string from child to parent

reader,writer = IO.pipe

fork do
  reader.close
  writer.puts "sent from child process"
end

writer.close
from_child = reader.gets
puts from_child
