# -*- encoding : utf-8 -*-
module ActiveSupport::Inflector
  def titleize_with_big(word)
    word[0] = word[0].gsub('å', 'Å')
    word[0] = word[0].gsub('ø', 'Ø')
    word[0] = word[0].gsub('æ', 'Æ')
    titleize_without_big(word)
  end

  alias_method_chain :titleize, :big
end

class String
  def downleize
    word = self
    word.downcase!
    word[0] = word[0].gsub('Å', 'å')
    word[0] = word[0].gsub('Ø', 'ø')
    word[0] = word[0].gsub('Æ', 'æ')
    return word
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
