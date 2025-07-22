
class UserService
  def self.create_user(email, password)
    user = JUser.new(
      email: email,
      password: password
    )
    # user.save! Sir yah error kar raha tha!!
    user
  end

  def self.update_user(user_id, email, password)
    user = JUser.find(user_id)
    user.update!(
      email: email,
      password: password,
      updated_at: Time.now
    )
    user
  end
end
