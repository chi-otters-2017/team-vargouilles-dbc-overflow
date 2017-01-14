# We no longer need this because the partial for adding a new answer has been added to the question page


post '/questions/:id/answers' do
  @question = Question.find(params[:id])
  @user = User.find(session[:user_id])
  @answer = Answer.new(response: params[:response], answerer_id: session[:user_id], question_id: params[:id])
  if @answer.save
    @votes = @answer.total_votes
    redirect "/questions/#{params[:id]}"
    if request.xhr?
      erb :"/answers/_show", layout: false
    else
      redirect :"/questions/#{params[:id]}"
    end
  else
    @errors = @answer.errors.full_messages
    erb :"/answers/_new"
  end
end

post '/answers/:id/comments' do
  @answer_comment = Comment.new(body: params[:body], commentor_id: session[:user_id], commentable_id: params[:id], commentable_type: "Answer")
  if @answer_comment.save
    @votes = @answer_comment.total_votes
      answer_id = @answer_comment.commentable_id
      answer = Answer.find_by(id: answer_id)
      question_id = answer.question_id

      redirect "/questions/#{question_id}"
    if request.xhr?
      # erb :"/answers/_show", layout: false
    else

    end
  else
    @errors = @answer.errors.full_messages
    erb :"/answers/_new"
  end
end

post '/answers/:id/votes' do
  vote_info = {
    voter_id: session[:user_id],
    value: params[:vote],
    votable_id: params[:id],
    votable_type: 'Answer'
  }

  @answer = Answer.find_by(id: params[:id])
  new_vote = Vote.new(vote_info)
  if new_vote.save
    # Need to find question_id before I can head there.
    redirect "/questions/#{@answer.question_id}"
  else
    @errors = new_vote.errors.full_messages
    @question = Question.find(@answer.question_id)
    erb :'/questions/show'
  end
end
