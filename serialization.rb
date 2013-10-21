# serialization.rb
# Ruby objects can be serialized by Marshal to move across pipes
# or sockets

Tire = Struct.new(:radius, :pressure)

reader, writer = IO.pipe

fork do
  reader.close
  tire = Tire.new(7, 28)
  tire_data = Marshal.dump(tire)
  writer.write tire_data
end

writer.close
tire_data = reader.gets
tire = Marshal.load(tire_data)
puts tire.inspect
