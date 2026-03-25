
def print_text(text)
  puts("Printing: #{text}")
  sleep 2
  puts("End")
end

def metrics(λ, time_decimals=1)
  elapsed_time = Benchmark.realtime {
    -> (*args, &callback) do
      # puts "⇓⇓⇓"
      (callback ? λ.call(*args, &callback) : instance_exec(*args, &λ)).tap do |result|
        puts result.inspect
        # puts "⇑⇑⇑"
      end
    end
  }
  puts "[Metrics] Time: " + "#{elapsed_time}".slice(0..(1 + time_decimals)) + " sec"
end

def wrap λ
  -> (*args, &cb) do
    puts "⇓⇓⇓"
    (cb ? λ.call(*args, &cb) : instance_exec(*args, &λ)).tap do |result|
      puts result.inspect
      puts "⇑⇑⇑"
    end
  end
end


# wrapped_proc = wrap(print_text("Test"))