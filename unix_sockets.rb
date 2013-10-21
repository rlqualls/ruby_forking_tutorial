# unix_sockets.rb
# creates a pair of UNIX sockets that send and receive a string

require 'socket'
parent_socket, child_socket = UNIXSocket.pair

fork do
  parent_socket.close
  child_socket.send("sent from child (#{$$})", 0)
  from_parent = child_socket.recv(100)
  puts from_parent
end

child_socket.close
parent_socket.send("sent from parent (#{$$})", 0)
from_child = parent_socket.recv(100)
puts from_child
