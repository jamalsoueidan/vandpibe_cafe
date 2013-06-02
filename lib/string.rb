class String
  def to_url
    value = self.gsub(' ', '-')
    value = value.downcase
    return value
  end
end