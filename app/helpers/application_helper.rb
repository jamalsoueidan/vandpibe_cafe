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

  def asset_host
    #asset = Rails.application.config.action_controller.asset_host
    #if asset.nil?
      return 'http://assets.vandpibecafe.dk/'
    #end
  end

  def vendored_include_tag(uri, type)
    uri = File.basename(uri) unless Rails.env.production? || Rails.env.staging?

    if type == "stylesheet"
      stylesheet_link_tag(uri)
    else
      javascript_include_tag(uri)
    end
  end

  def vendored_stylesheet_link_tag(uri)
    vendored_include_tag(uri, 'stylesheet')
  end

  def vendored_javascript_include_tag(uri)
    vendored_include_tag(uri, 'javascript')
  end
end
