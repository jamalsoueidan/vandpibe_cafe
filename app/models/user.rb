class User < ActiveRecord::Base
  has_many :questions
  has_many :ratings do
    def has_rated?(options={})
      self.exists?(options)
    end
  end
  
  has_many :comments
  
  def self.omniauth(auth)
    user = User.new
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    
    user_info = auth['info']
    
    if auth['extra'] && auth['extra']['user_hash']
      user_info.merge!(auth['extra']['user_hash'])
    end
        
    if user_info
      user.gender = user_info['gender'] unless user_info['email'].blank?
      user.email = user_info['email'] unless user_info['email'].blank?
      
      user.fullname   = user_info['name']   unless user_info['name'].blank?
      user.fullname ||= (user_info['first_name']+" "+user_info['last_name']) unless user_info['first_name'].blank? || user_info['last_name'].blank?
      
      user.nickname = user_info['nickname'] unless user_info['nickname'].blank?
      
      if user_info["image"].nil?
        user.avatar_url = DEFAULT_AVATAR_URL
      else
        user.avatar_url = user_info["image"]
      end
    end
    
    p user_info['gender']
    
    user.created_date = Time.now
    
    return user
  end

end
