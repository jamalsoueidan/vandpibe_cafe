module LocationsHelper
  def has_rated?(comment_ids)
    current_user.ratings.has_rated?(:rating_key => ['rate_service', 'rate_waterpipe', 'rate_furniture'], :rating_id => comment_ids, :rating_type => 'Comment', )
  end
end
