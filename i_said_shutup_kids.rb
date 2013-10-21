# i_said_shutup_kids.rb
# Signal responses can be customized using Kernel#trap or Signal#trap
# Send interrupt with ctrl-c to shutup

kids = %w{Bubba Montana}

kids.each do |kid|
  fork do
    @whiny = true
    trap("INT") do
      puts "#{kid}: Ugh! Shutup signal RECEIVED, dad!"
      @whiny = false
    end

    loop do
      puts "#{kid}: when.will.we.get...there"
      sleep rand(1..2)
      break if not @whiny
    end

  end
end

Process.waitall
