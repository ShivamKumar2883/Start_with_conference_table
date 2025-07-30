object @user

attributes :id, :email

child :profile do
  extends 'profiles/show'
end

if @access_token.present?
  node(:access_token) { @access_token }
  node(:refresh_token) { @refresh_token }
end

child :posts do
  extends 'posts/show'
end