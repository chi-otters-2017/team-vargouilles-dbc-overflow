require_relative '../helpers/post_parser'
class Question < ActiveRecord::Base
  include PostParser
  # Remember to create a migration!
  belongs_to :author,  class_name: 'User', foreign_key: :author_id
  has_many :comments, as: :commentable
  has_many :votes, :as => :votable
  has_many :answers

#PostParser adds
#==================
# plural_model_name
# => returns the model name lowercase and plural for general routes
# total_votes
#=> returns vote count
# comments
#=> returns owned comments
end
