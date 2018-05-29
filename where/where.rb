module Where
  def where(hash={})
    results = []
    self.each do |item|
      match = false
      hash.each do |k,v|
        if item[k].to_s.match(v.to_s)
          match = true
        else
          break
        end
      end
      results << item if match
    end
    results
  end
end
