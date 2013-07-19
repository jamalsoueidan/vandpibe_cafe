class User < ActiveRecord::Base
  has_many :ratings
  has_many :comments

  ADMIN = 2
  MODERATOR = 1
    
  def self.annonym
    if !User.exists?(:nickname => 'anonym')
      user = User.new
      user.nickname = 'Anonym'
      user.fullname = 'Anonym'
      user.email = 'anonym@soueidan.com'
      user.avatar_url = 'http://assets.vandpibecafe.dk/assets/anonym.gif'
      user.save
      return user
    else
      User.find_by_nickname('anonym')
    end
  end
  
  def is_admin?
    status == ADMIN
  end
  
  def is_moderator?
    status >= MODERATOR
  end
  
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
