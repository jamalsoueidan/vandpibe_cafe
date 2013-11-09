# -*- encoding : utf-8 -*-
class String
  def utf8!
    self.gsub!('aa', 'å')
    self.gsub!('oe', 'ø')
    self.gsub!('ae', 'æ')
    self.gsub!('+', ' ')
    self.gsub!('-', ' ')
  end
  
  def utf8
    text = self
    text.gsub!('aa', 'å')
    text.gsub!('oe', 'ø')
    text.gsub!('ae', 'æ')
    text.gsub!('+', ' ')
    text.gsub!('-', ' ')
    return text
  end
  
  def big
    string = self.titleize
    string[0] = string[0].gsub('å', 'Å')
    string[0] = string[0].gsub('ø', 'Ø')
    string[0] = string[0].gsub('æ', 'Æ')
    return string
  end
end

module FindByURL
  extend ActiveSupport::Concern
  
  module ClassMethods
    def find_by_url(name, city_id=nil)
      name.downcase!
      models = self.where("#{self.table_name}.name = ? OR #{self.table_name}.name = ?", name, name.utf8)
      if city_id
        models = models.where(:city_id => city_id)
      end
      models.first
    end
  end
end

ActiveRecord::Base.send(:include, FindByURL)
