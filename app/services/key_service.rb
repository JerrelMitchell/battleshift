class KeyService
  def initialize(user)
    @user = user
  end

  def create_key
    key = SecureRandom.urlsafe_base64
    if User.find_by(key: key)
      create_key
    else
      @user.update!(key: key)
      key
    end
  end
end
