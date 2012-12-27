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
end
