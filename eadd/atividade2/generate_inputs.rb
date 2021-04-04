require "set"

srand 1234
(10..27).each do |exp|
  input_elems = Set[]
  while input_elems.size < (2**exp)
    input_elems << rand(2**(exp+1))
  end

  File.open("./inputs/exp_2_#{exp}.txt", "w") do |file|
    input_elems.each { |input| file.write("#{input}\n") }
  end
end
