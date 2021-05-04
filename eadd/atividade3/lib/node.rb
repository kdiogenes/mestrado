class Node
  attr_accessor :val, :next, :prev
  
  def initialize(val)
    @val = val  
    @next = nil
    @prev = nil
  end

  def pretty_print(pp)
    if pp.current_group.depth <= 4
      pp.pp_object(self)
    else
      pp.pp(self)
    end
  end
end