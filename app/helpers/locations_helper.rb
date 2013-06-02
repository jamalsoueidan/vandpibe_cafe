module LocationsHelper
  def has_rated?(comment_ids)
    current_user.ratings.has_rated?(:rating_key => ['rate_service', 'rate_waterpipe', 'rate_furniture'], :rating_id => comment_ids, :rating_type => 'Comment', )
  end
  def toplist_title
    order = params[:order]
    order.gsub!('bedste+','') unless order.nil?
    if order == 'vandpibe'
      'Top 10 Bedste Vandpibe'
    elsif order == 'stemning'
      'Top 10 Bedste Stemning'
    elsif order == 'indretning'
      'Top 10 Bedste Indretning'
    elsif order == 'service'
      'Top 10 Bedste Service'
    else
      'Top 10 Vandpibe Cafeer'
    end
  end

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

  # = image_tag_unless(location.uploads.first.avatar.path(:medium), location.uploads.empty?, :class => "bottom-left-corner")
  def image_tag_unless(uploads, options={})
    if uploads.empty?
      image_tag(asset_host + "assets/thumb.gif", options)
    else
      image_tag(asset_host + uploads.first.avatar.path(:medium), options)
    end
  end
end
