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
