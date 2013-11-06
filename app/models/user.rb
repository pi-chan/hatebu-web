class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :rememberable,:omniauthable

  def rememberable_value
  end

  def self.new_with_session(params, session)
  end

  def self.find_for_hatena_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      user.update(token:auth.credentials.token,
                  secret:auth.credentials.secret)

    else
      user = User.create(name:auth.uid,
                         uid:auth.uid,
                         provider:auth.provider,
                         token:auth.credentials.token,
                         secret:auth.credentials.secret)
    end
    user
  end

  def bookmark(url)
    true
  end
  
end
