module PostParser

  def plural_model_name
    [self.model_name.name.downcase,"s"].join
  end

  def comments
    Comment.where(commentable_type: self.model_name.name, commentable_id: self.id)
  end

  def total_votes
    total = 0
    self.votes.each do |vote|
      total += vote.value
    end
    total
  end

  def votes
    Vote.where(votable_type: self.model_name.name, votable_id: self.id)
  end

end

helpers PostParser

