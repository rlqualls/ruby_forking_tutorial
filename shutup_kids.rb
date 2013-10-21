# shutup_kids.rb
# If a process receives an interrupt signal, it will pass it on to its children
# Send SIGINT with ctrl-c to make the kids shut up

kids = %w{Bubba Montana}

kids.each do |kid|
  fork do
    loop do
      puts "#{kid}: when.will.we.get.there."
      sleep 1
    end
  end
end

Process.waitall
