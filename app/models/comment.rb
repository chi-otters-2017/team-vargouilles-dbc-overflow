class Comment < ActiveRecord::Base
  validates :body, presence: true
  belongs_to :commenter, class_name: 'User'
  belongs_to :commentable, polymorphic: true

end
