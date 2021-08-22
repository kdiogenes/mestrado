require "json"

require_relative "quicksort"

qs_recursive = Quicksort::Recursive.new
qs_iterative = Quicksort::Iterative.new

## small example for use the quicksort implementations
# input = [4, 2, 6, 9, 2]
# qs_recursive.sort(input, 0, input.length - 1)
# p input

# input = [4, 2, 6, 9, 2]
# qs_iterative.sort(input, 0, input.length - 1)
# p input

# exit 0

input_sizes = [
  100,
  200,
  500,
  1_000,
  2_000,
  5_000,
  7_500,
  10_000,
  15_000,
  30_000,
  50_000,
  75_000,
  100_000,
  200_000,
  500_000,
  750_000,
  1_000_000,
  1_250_000,
  1_500_000,
  2_000_000
]

def measuring_time
  start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  yield
  finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  finish - start
end

results = {
  recursive: { random: [], ordered_decreasing: [], ordered: [], partial_ordered: [] },
  iterative: { random: [], ordered_decreasing: [], ordered: [], partial_ordered: [] }
}

# small example to print on screen quicksort times for the random input
# input_sizes.each do |input_size|
# 	# random input
# 	recursive_times = []
# 	iterative_times = []
  
# 	5.times do
# 		file = File.new("inputs/random/a#{input_size}.txt")
# 		input_recursive = []
# 		input_iterative = []
# 		file.each do |line|
# 			input_recursive << line.to_i
# 			input_iterative << line.to_i
# 		end

# 		recursive_times << measuring_time { qs_recursive.sort(input_recursive, 0, input_recursive.length - 1) }
# 		iterative_times << measuring_time { qs_iterative.sort(input_iterative, 0, input_iterative.length - 1) }
# 	end

# 	p "Input size: #{input_size}"
# 	p "QS recursive: #{recursive_times.sum / 5} (#{recursive_times.join(", ")})"
# 	p "QS iterative: #{iterative_times.sum / 5} (#{iterative_times.join(", ")})"
# end

# exit 0

##
# Quicksort implementations (recursive vs iterative) comparison for each input type (random, ordered_decreasing, ordered
# and partial_ordered)
input_sizes.each do |input_size|
  p "Executing quicksort on input size: #{input_size}"
  
  # random input
  recursive_times = []
  iterative_times = []
  
  5.times do
    file = File.new("inputs/random/a#{input_size}.txt")
    input_recursive = []
    input_iterative = []
    file.each do |line|
      input_recursive << line.to_i
      input_iterative << line.to_i
    end

    recursive_times << measuring_time { qs_recursive.sort(input_recursive, 0, input_recursive.length - 1) }
    iterative_times << measuring_time { qs_iterative.sort(input_iterative, 0, input_iterative.length - 1) }
  end
  
  results[:recursive][:random] << recursive_times
  results[:iterative][:random] << iterative_times
  p "QS recursive (random): #{recursive_times}"
  p "QS iterative (random): #{iterative_times}"

  # ordered decreasing input
  recursive_times = []
  iterative_times = []
  
  5.times do
    file = File.new("inputs/ordered_decreasing/d#{input_size}.txt")
    input_recursive = []
    input_iterative = []
    file.each do |line|
      input_recursive << line.to_i
      input_iterative << line.to_i
    end

    recursive_times << measuring_time { qs_recursive.sort(input_recursive, 0, input_recursive.length - 1) }
    iterative_times << measuring_time { qs_iterative.sort(input_iterative, 0, input_iterative.length - 1) }
  end

  results[:recursive][:ordered_decreasing] << recursive_times
  results[:iterative][:ordered_decreasing] << iterative_times
  p "QS recursive (ordered decreasing): #{recursive_times}"
  p "QS iterative (ordered decreasing): #{iterative_times}"

  # ordered input
  recursive_times = []
  iterative_times = []
  
  5.times do
    file = File.new("inputs/ordered/o#{input_size}.txt")
    input_recursive = []
    input_iterative = []
    file.each do |line|
      input_recursive << line.to_i
      input_iterative << line.to_i
    end

    recursive_times << measuring_time { qs_recursive.sort(input_recursive, 0, input_recursive.length - 1) }
    iterative_times << measuring_time { qs_iterative.sort(input_iterative, 0, input_iterative.length - 1) }
  end

  results[:recursive][:ordered] << recursive_times
  results[:iterative][:ordered] << iterative_times
  p "QS recursive (ordered): #{recursive_times}"
  p "QS iterative (ordered): #{iterative_times}"

  # partial ordered input
  recursive_times = []
  iterative_times = []
  
  5.times do
    file = File.new("inputs/partial_ordered/po#{input_size}.txt")
    input_recursive = []
    input_iterative = []
    file.each do |line|
      input_recursive << line.to_i
      input_iterative << line.to_i
    end

    recursive_times << measuring_time { qs_recursive.sort(input_recursive, 0, input_recursive.length - 1) }
    iterative_times << measuring_time { qs_iterative.sort(input_iterative, 0, input_iterative.length - 1) }
  end

  results[:recursive][:partial_ordered] << recursive_times
  results[:iterative][:partial_ordered] << iterative_times
  p "QS recursive (partial ordered): #{recursive_times}"
  p "QS iterative (partial ordered): #{iterative_times}"
end

File.write("outputs/results.json", JSON.generate(results))