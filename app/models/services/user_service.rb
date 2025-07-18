module Services
class UserService
  def self.create_user(email, password)
    user = JUser.new(
      email: email,
      password: password,
      createdAt: Time.now,
      updateAt: Time.now
    )
    user.save!
    user
  end

  def self.update_user(user_id, email, password)
    user = JUser.find(user_id)
    user.update!(
      email: email,
      password: password,
      updateAt: Time.now
    )
    user
  end
end
end