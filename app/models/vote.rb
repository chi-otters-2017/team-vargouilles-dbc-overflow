class Vote < ActiveRecord::Base
  belongs_to :voter, { class_name: "User" }
  belongs_to :votable, polymorphic: true

  validates :value, inclusion: {:in => [1, -1, 0]}

  validate :user_not_voted_on_this

  def user_not_voted_on_this
    vote_info = { votable_id: self.votable_id,
                  votable_type: self.votable_type,
                  voter_id: self.voter_id
                }
    unless !Vote.exists?(vote_info)
      errors.add :voter_id, "Already voted!"
    end
  end
end
