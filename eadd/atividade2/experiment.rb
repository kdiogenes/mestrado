require "json"

require "./array/search_algorithms"

srand 4321

results = {
  sequential: {},
  sequential_optimized: {},
  jump_search: {},
  binary_search: {}
}

def measuring_time
  start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  
  position = yield
  
  finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  elapsed_time = finish - start
  
  [position, elapsed_time]
end

(10..27).each do |exp|
  search_values = 100.times.map { rand(2**exp) }
  file = File.new("inputs/exp_2_#{exp}.txt")
  input = []
  file.each { |line| input << line.to_i }
  ordered_input = input.sort
  
  results[:sequential][exp] ||= []
  results[:sequential_optimized][exp] ||= []
  results[:jump_search][exp] ||= []
  results[:binary_search][exp] ||= []

  100.times do |i|
    position, elapsed_time = measuring_time { input.sequential_search(search_values[i]) }
    results[:sequential][exp] << { position: position, elapsed_time: elapsed_time }

    position, elapsed_time = measuring_time { ordered_input.optimized_sequential_search(search_values[i]) }
    results[:sequential_optimized][exp] << { position: position, elapsed_time: elapsed_time }

    position, elapsed_time = measuring_time { ordered_input.jump_search(search_values[i]) }
    results[:jump_search][exp] << { position: position, elapsed_time: elapsed_time }

    position, elapsed_time = measuring_time { ordered_input.binary_search(search_values[i]) }
    results[:binary_search][exp] << { position: position, elapsed_time: elapsed_time }
  end
end

File.write("outputs/experiment_generated_data.txt", JSON.generate(results))
