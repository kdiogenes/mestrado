require "json"

require "./lib/node"
require "./lib/doubly_linked_list"

srand 4321

results = {
  sequential: {},
  binary_search: {}
}

def measuring_time
  start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  
  position = yield
  
  finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  elapsed_time = finish - start
  
  [position, elapsed_time]
end

(10..20).each do |exp|
  p "Processing 2**#{exp}..."
  search_values = 100.times.map { rand(2**exp) }
  file = File.new("inputs/exp_2_#{exp}.txt")
  input = []
  file.each { |line| input << line.to_i }
  
  unsorted_list = DoublyLinkedList.new
  sorted_list = DoublyLinkedList.new
  
  start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  input.each { |val| unsorted_list.push(val) }
  finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  unsorted_time = finish - start
  p "Unsorted time: #{unsorted_time}"
  
  start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  input.each { |val| sorted_list.insert_sorted(val) }
  finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  sorted_time = finish - start
  p "Sorted time: #{sorted_time}"

  results[:sequential][exp] ||= []
  results[:binary_search][exp] ||= []

  100.times do |i|
    p "Searching #{search_values[i]} using sequential search on unsorted list..."
    position, elapsed_time = measuring_time { unsorted_list.sequential_search(search_values[i]) }
    p "Position: #{position} / time: #{elapsed_time}"
    results[:sequential][exp] << { position: position, elapsed_time: elapsed_time, insertion_time: unsorted_time }

    p "Searching #{search_values[i]} using binary search on sorted list..."
    position, elapsed_time = measuring_time { sorted_list.binary_search(search_values[i]) }
    p "Position: #{position} / time: #{elapsed_time}"
    results[:binary_search][exp] << { position: position, elapsed_time: elapsed_time, insertion_time: sorted_time }
  end
end

File.write("outputs/experiment_generated_data.txt", JSON.generate(results))
