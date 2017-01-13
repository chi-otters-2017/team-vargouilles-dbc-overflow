class Vote < ActiveRecord::Base
  validates :value, inclusion: {:in => [1, -1, 0]}

  belongs_to :voter, { class_name: "User" }
  belongs_to :votable, polymorphic: true

end
