object @post

attributes :id, :title, :content, :posted_by, :created_at, :updated_at

child :j_user do
  attributes :email
end