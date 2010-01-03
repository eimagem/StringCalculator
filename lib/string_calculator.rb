module StringCalculator
  def add
    return 0  if empty?
    raise_if_negatives_present
    digits.inject {|sum, x| sum + x}
  end
  
  def raise_if_negatives_present
    if negatives.any?
      raise "Negative not allowed: #{negatives.join(', ')}"
    end
  end
  
  def negatives
    @negatives ||= digits.select{|x| x < 0}
  end
  def digits
     gsub("\n", delimiter).split(delimiter).map {|x| x.to_i }
  end
  
  def delimiter
    @delimiter ||= self[0,2] == '//' ? delimiter = self[2,1] : ','
  end
end