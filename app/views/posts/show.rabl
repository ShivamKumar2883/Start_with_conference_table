object @profile

attributes :id, :name, :designation, :address, :phone_number, :pincode

node(:profile_pic) { |p| p.profile_picture&.image_url }
node(:user_id) { |p| p.j_user_id }

node(:user_email) { |p| p.j_user.email }