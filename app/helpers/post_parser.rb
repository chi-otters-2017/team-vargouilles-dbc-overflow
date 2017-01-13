module PostParser

  def plural_model_name
    [self.model_name.name.downcase,"s"].join
  end

  def total_votes
    total = 0
    answer.votes.each do |vote|
      total+= vote.value
    end
  end

  def comments
    Comment.where(commentable_type: self.model_name.name, commentable_id: self.id)
  end

end

helpers PostParser

