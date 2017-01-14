require_relative '../helpers/post_parser'

class Comment < ActiveRecord::Base
  include PostParser

  validates :body, presence: true
  belongs_to :commentor, class_name: 'User', foreign_key: :commentor_id
  belongs_to :commentable, polymorphic: true
  has_many :votes, as: :votable

  def parent_question
    if self.commentable_type == 'Question'
      Question.find(self.commentable_id)
    else
      Answer.find(self.commentable_id).question
    end
  end
end
