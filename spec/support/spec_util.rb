def create_user
  uid = SecureRandom.urlsafe_base64(5),
  token = SecureRandom.urlsafe_base64(10),
  secret = SecureRandom.urlsafe_base64(10),
  user = User.create( uid:uid,
                      name:uid,
                      provider: :hatena,
                      token: token,
                      secret: secret )
  user
end

def setup_omniauth_test(user)
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[user.provider] = OmniAuth::AuthHash.new({
    'provider' => user.provider,
    'uid' => user.uid,
    "credentials" => {
      "token" => user.token,
      "secret" => user.secret
    }
  })
end

