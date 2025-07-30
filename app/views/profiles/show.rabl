if @posts
  collection @posts
else
  object @post
end

attributes :id, :title, :content, :posted_by, :created_at, :updated_at

child :j_user do
  attributes :id, :email
  node(:profile_name) { |u| u.profile.name }
end

node(:current_user_liked) { |p| current_user.liked?(p) rescue false }