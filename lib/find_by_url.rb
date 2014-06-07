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
    replace(utf8)
  end

  def utf8
    text = self
    text.gsub!('aa', 'å')
    text.gsub!('oe', 'ø')
    text.gsub!('ae', 'æ')
    text.gsub!('+', ' ')
    text.gsub!('-', ' ')
    text.downcase!
    return text
  end
end

module FindByURL
  extend ActiveSupport::Concern

  module ClassMethods
    def find_by_url(name, city)
      return self.where("#{self.table_name}.name = ? OR #{self.table_name}.city = ?", name.utf8, city.utf8)
    end
  end
end

ActiveRecord::Base.send(:include, FindByURL)
