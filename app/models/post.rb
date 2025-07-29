class Post < ApplicationRecord
    belongs_to :user, class_name: 'JUser', foreign_key: 'user_id'
end
