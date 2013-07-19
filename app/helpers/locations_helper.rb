module LocationsHelper
  def rating(location, options)
    if options[:score].nil?
      options[:score] = location.ratings.calculate_by_key(options[:class]).to_s
    end
    
    options[:class] = options[:class] + "_" + location.id.to_s
    content_tag :div, options do
      javascript_tag do
        raw("$('." + options[:class] + "').raty({ score: " + options[:score].to_s + ", halfScore: true})")
      end
    end
  end

  def raty(name, options)
    new_name = name + Random.rand(100000).to_s
    content_tag :div, :class => new_name do
      javascript_tag do
        raw("$('.#{new_name}').raty(#{options.to_json})")
      end
    end
  end

  # = image_tag_unless(location.uploads.first.avatar.path(:medium), location.uploads.empty?, :class => "bottom-left-corner")
  def image_tag_unless(uploads, options={})
    if uploads.empty?
      image_tag(asset_host + "assets/thumb.gif", options)
    else
      image_tag(asset_host + uploads.first.avatar.path(:medium), options)
    end
  end
end
