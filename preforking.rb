# preforking.rb
# Starts an echo server that can service up to 3 clients in parallel

require 'socket'

server = TCPServer.new 'localhost', 3000

trap("EXIT") { socket.close }
trap("INT") { exit }

3.times do
  fork do
    sock = server.accept
    sock.puts "You are connected to process #{$$}:"
    while recv = sock.gets
      sock.puts("ECHO:> #{recv}")
    end
  end
end

Process.waitall
