object @profile

attributes :name, :designation, :address, :phone_number, :pincode

node(:profile_pic) { |profile| profile.profile_picture&.image_url }