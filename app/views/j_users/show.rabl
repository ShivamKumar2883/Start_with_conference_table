object @user

attributes :id, :email

child :profile do
  attributes :name, :designation, :address, :phone_number, :pincode
  
  node(:profile_pic) { |profile| profile.profile_picture&.image_url }
end

node(:access_token) { @access_token }
node(:refresh_token) { @refresh_token }