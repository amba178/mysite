class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :confirmable, :timeoutable,
         :lockable, :omniauthable
   validates_presence_of :first_name, :last_name, :email
   validates_presence_of :password, :on => :create 
   validates_presence_of :password_confirmation, :on => :create  

  def self.from_omniauth(auth)
  	where(:provider => auth.provider, :uid => auth.uid).first_or_create do |user|
    	user.email = auth.info.email
    	user.uid = auth.uid
    	user.provider = auth.provider
    	user.nickname = auth.info.nickname 
    	user.first_name = auth.info.name.split(' ')[0]
    	user.last_name = auth.info.name.split(' ')[1]
    	# user.password = Devise.friendly_token[0,20]
    	# user.first_name = auth.info.name   # assuming the user model has a name
    	user.image = auth.info.image # assuming the user model has an image
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

 # def update_without_password(params, *options)
 # 	if encrypted_password.blank? 
 # 	     params.delete(:password, :password_confirmation)
 # 	     # update_attributes(params, *options)
 # 	     super(params)
 # 	end
 # end


end
