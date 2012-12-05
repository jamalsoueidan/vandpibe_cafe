module ApplicationHelper
  def current_class(path)
    return ' active' if current_page?(path)
    ''
  end
  
  def li_link(title, path)
    content_tag 'li', link_to(title, path), :class => current_class(path)
  end
  
  def active_class(condtion)
    if condition.kind_of?(Array)
      
    else
      
    end
  end
end
