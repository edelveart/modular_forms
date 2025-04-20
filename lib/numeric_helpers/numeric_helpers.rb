
module NumericHelpers

  def self.factorial_iter(num)
    t = 1
    (1..num).each do |i|
      t = t * i
    end
    t
  end


end
