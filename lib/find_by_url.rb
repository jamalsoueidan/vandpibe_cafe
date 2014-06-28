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
  def urls
    [['aa', 'å'], ['oe', 'ø'], ['ae', 'æ'], ['+', ' ']]
  end

  def to_uri!
    replace(to_url)
  end

  def to_para
    text = self
    text.downcase!
    urls.each do |u|
      text.gsub!(u[1], u[0])
    end
    return text
  end

  def to_string
    text = self
    text.downcase!
    urls.each do |u|
      text.gsub!(u[0], u[1])
    end
    return text
  end
end

module FindByURL
  extend ActiveSupport::Concern

  module ClassMethods
    def find_by_url(name, city)
      return self.where("#{self.table_name}.name = ? && #{self.table_name}.city = ?", name.titleize.downcase, city)
    end
  end
end

ActiveRecord::Base.send(:include, FindByURL)
