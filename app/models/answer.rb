class Answer < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :question
  belongs_to :answerer, { class_name: 'User'}
  has_many :votes, :as => :votable
  has_many :comments, as: :commentable

  def total_votes
    total = 0
    answer.votes.each do |vote|
      total+= vote.value
    end
  end

end
