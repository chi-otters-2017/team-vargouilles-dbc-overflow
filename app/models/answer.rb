require_relative '../helpers/post_parser'
class Answer < ActiveRecord::Base
  include PostParser

  # Remember to create a migration!
  belongs_to :question

  belongs_to :answerer,  class_name: 'User'

  has_many :votes, :as => :votable
  has_many :comments, as: :commentable

#PostParser adds
#==================
# plural_model_name
# => returns the model name lowercase and plural for general routes
# total_votes
#=> returns vote count
# comments
#=> returns owned comments
end
