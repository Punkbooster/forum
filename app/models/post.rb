class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments

	scope :recent, ->{ order("created_at DESC" )}
	scope :active, ->{ where("comments_count >= ?", 5)}
	scope :unanswered, ->{ where(comments_count: 0 )}
end
