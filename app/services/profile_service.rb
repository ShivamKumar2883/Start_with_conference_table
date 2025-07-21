class ProfileService
  


    def self.create_profile(j_user_id, profile_params)

    if Profile.exists?(j_user_id: j_user_id)
      raise ActiveRecord::RecordNotUnique, "User already has a profile"
    end

    profile = Profile.new(
      j_user_id: j_user_id,
      name: profile_params[:name],
      designation: profile_params[:designation],
      address: profile_params[:address],
      phone_number: profile_params[:phone_number],
      pincode: profile_params[:pincode],
      profile_pic: profile_params[:profile_pic]
    )
    profile.save!
    profile
  end



  def self.update_profile(j_user_id, profile_params)
    profile = Profile.find_by!(j_user_id: j_user_id)
    
    profile.update!(
      name: profile_params[:name],
      designation: profile_params[:designation],
      address: profile_params[:address],
      phone_number: profile_params[:phone_number],
      pincode: profile_params[:pincode],
      profile_pic: profile_params[:profile_pic],
      updated_at: Time.now
    )
    profile
  end

  def self.get_profile(j_user_id)
    Profile.find_by!(j_user_id: j_user_id)
  end
end