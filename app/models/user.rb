class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    user = User.find_by('email = ?', auth['info']['email'])
    if user.blank?
      user = User.new(
        {
          provider: auth.provider,
          uid: auth.uid,
          email: auth.info.email,
          password: Devise.friendly_token[0,20]
        })
      user.save!
    end
    user
  end

  # def self.from_omniauth(authentication_data)
  #   if User.where(provider: authentication_data['provider'],
  #                     uid: authentication_data['uid']).exists?
  #     user = User.where(provider: authentication_data['provider'],
  #                     uid: authentication_data['uid']).first
  #   else
  #     user = User.where(provider: authentication_data['provider'],
  #                       uid: authentication_data['uid']).create
  #
  #     Rails.logger.debug "The user is #{user.inspect}"
  #     Rails.logger.debug "The authinfo is #{authentication_data.info}"
  #
  #     user.name         = authentication_data.info.name
  #     user.nickname     = authentication_data.info.nickname
  #     user.access_token = authentication_data.info.access_token
  #     user.profile_url  = authentication_data.info.urls
  #     user.email        = authentication_data.info.email
  #
  #     user.save!
  #   end
  #
  #   Rails.logger.debug "After saving, the user is #{user.inspect}"
  #
  #   return user
  # end
end
