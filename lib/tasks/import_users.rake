require 'csv'

namespace :import do
    task users: :environment do

    filename = File.join Rails.root, "user_data.csv"
    #  for checking the csv file content
    #   CSV.foreach(filename) do |row|
    # p row
    # On Console: bundle exec rake import:users

    data = File.read(filename)
    rows = data.split("\n")

    rows.shift
    #iske add se row shift hoga after each user creation

    rows.each do |row|
        values = row.split(",")

        user = JUser.new
        user.email = values[0]
        user.password = values[1]
        # user.save!

        profile = Profile.new
        profile.j_user_id = user.id
        profile.name = "#{values[2]} #{values[3]}"
        profile.designation = values[4]
        profile.address = values[5]
        profile.phone_number = values[6]
        profile.pincode = values[7]
        profile.profile_pic = values[8]
        user.save
        profile.save

        puts "User with profile are created" 
        # command to remember for rack: rake import:users
    end
end
end