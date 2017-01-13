class Comment < ActiveRecord::Base
  validates :body, presence: true
  belongs_to :commentor, class_name: 'User', foreign_key: :commentor_id
  belongs_to :commentable, polymorphic: true
  has_many :votes, as: :votable

end
