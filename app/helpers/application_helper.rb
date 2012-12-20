module ApplicationHelper
  def current_class(path)
    return ' active' if current_page?(path)
    ''
  end
  
  def li_link(title, path)
    content_tag 'li', link_to(title, path), :class => current_class(path)
  end
  
  def breadcrumbs(options={})
    content_tag :ul, :class => :breadcrumbs do
      concat(content_tag :li, link_to('Start side', '/'))
      options.each_with_index do |key, index| 
        is_current_url = ( options.length == (index+1) ? 'current' :  '')
        concat(content_tag(:li, link_to(key[0], key[1]), :class => is_current_url)) 
      end
    end
  end
  
  def active_class(condtion)
    if condition.kind_of?(Array)
      
    else
      
    end
  end
  
  def asset_host
    #asset = Rails.application.config.action_controller.asset_host
    #if asset.nil?
      return 'http://assets.vandpibecafe.dk/'
    #end
  end
end
