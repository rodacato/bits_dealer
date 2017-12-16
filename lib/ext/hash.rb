class Hash
  def slice(*keys)
    self.select {|key, value| keys.include?(key) }
  end
end
