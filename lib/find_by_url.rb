module ActiveSupport::Inflector
  def titleize_with_big(word)
    word[0] = word[0].gsub('å', 'Å')
    word[0] = word[0].gsub('ø', 'Ø')
    word[0] = word[0].gsub('æ', 'Æ')
    titleize_without_big(word)
  end

  alias_method_chain :titleize, :big
end
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
