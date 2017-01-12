class Question < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :author,  class_name: 'User', foreign_key: :author_id
  has_many :comments, as: :commentable
  has_many :votes, :as => :votable
  has_many :answers

  def comments
    Comment.where(commentable_type: 'Question', commentable_id: id )
  end

end
