# -*- encoding : utf-8 -*-
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
VandpibeCafe::Application.initialize!

class String
  def utf8!
    self.gsub!('aa', 'å')
    self.gsub!('oe', 'ø')
    self.gsub!('ae', 'æ')
    self.gsub!('+', ' ')
    self.gsub!('-', ' ')
  end
  
  def big
    string = self.titleize
    string[0] = string[0].gsub('å', 'Å')
    string[0] = string[0].gsub('ø', 'Ø')
    string[0] = string[0].gsub('æ', 'Æ')
    return string
  end
end

WillPaginate.per_page = 10