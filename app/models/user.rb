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
    @consumer = OAuth::Consumer.new(
      ENV['HATENA_CONSUMER_KEY'],
      ENV['HATENA_CONSUMER_SECRET'],
      site:'',
      request_token_path: 'https://www.hatena.com/oauth/initiate',
      access_token_path: 'https://www.hatena.com/oauth/token',
      authorize_path: 'https://www.hatena.ne.jp/oauth/authorize'
    )

    access_token = OAuth::AccessToken.new(
      @consumer,
      self.token,
      self.secret
    )

    xml = <<-XML
      <entry xmlns="http://purl.org/atom/ns#">
        <title>dummy</title>
        <link rel="related" type="text/html" href="#{url}" />
      </entry>
    XML

    response = access_token.post(
      "http://b.hatena.ne.jp/atom/post",
      xml,
      {'Content-Type' => 'application/xml'}
    )

    return response.code == "201"
  end
  
end
