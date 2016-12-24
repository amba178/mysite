class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :charges  

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :confirmable, :timeoutable,
         :lockable, :omniauthable, :omniauth_providers => [:facebook, :twitter]
   validates_presence_of :first_name, :last_name, :email
   # after_create :skip_confirmation_auth 
    validates_presence_of :password, :on => :create 
    validates_presence_of :password_confirmation, :on => :create  

   def total_donation
     charges.pluck(:amount).reduce(:+) 
   end

  def self.from_omniauth(auth)
  	where(:provider => auth.provider, :uid => auth.uid).first_or_initialize do |user|
    	user.email =    auth.info.email.nil? ?  "#{SecureRandom.base64(10)[0..13]}.gmail.com" : auth.info.email 
    	user.uid = auth.uid
    	user.provider = auth.provider
      user.auth_token = auth.credentials.token
    	user.nickname = auth.provider == 'twitter' ?  auth.info.nickname : auth.info.name
    	user.first_name = auth.info.name.split.first
    	user.last_name = auth.info.name.split.last
    	user.password = Devise.friendly_token[0,20]
      user.skip_confirmation_notification
    	# user.first_name = auth.info.name   # assuming the user model has a name
    	user.image = auth.info.image # assuming the user model has an image
      user.save

 	 end
  end

  def self.new_with_session(params, session)
 	 if session["devise.user_attributes"]
    	new(session["devise.user_attributes"]) do |user|
     		 user.attributes = params
      		 user.valid?
   		 end
  	else
      super
   end
 end

 def name
  "#{first_name} #{last_name}"
 end




def facebook
  @facebook ||= Koala::Facebook::API.new(auth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
   nil # or consider a custom null object
end

def friends_count
  facebook { |fb| fb.get_connection("me", "friends").size }
end



 # def password_required? 
 # 	super && provider.blank?
 # end

 # def update_with_password(params, *options)
 # 	if encrypted_password.blank?
 # 		update_attributes(params, *options)
 # 	else
 # 		super
 # 	end

 # end

 def skip_confirmation_auth 
  if self.provider
     self.skip_confirmation_notification! 
     self.confirmed_at = Time.now
  end
 end

 # def update_without_password(params, *options)
 # 	if encrypted_password.blank? 
 # 	     params.delete(:password, :password_confirmation)
 # 	     # update_attributes(params, *options)
 # 	     super(params)
 # 	end
 # end


end
