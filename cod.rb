# cod.rb
# The cod gem simplifies IPC. Ruby objects can be sent across channels.
# Installation: 
#   $ gem install cod

require 'cod'

Tire = Struct.new(:radius, :pressure)

channel = Cod.pipe

3.times do
  fork do
    radius = rand(8..14)
    pressure = rand(24..33)
    channel.put Tire.new(radius, pressure)
  end
end

tires = 3.times.map { channel.get }
puts tires.inspect
