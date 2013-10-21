# parent_child_pipe.rb
# creates a fork and pipes a string from parent to child

reader,writer = IO.pipe

fork do
  writer.close
  from_parent = reader.gets
  puts from_parent
end

reader.close
writer.write "sent from parent process"
