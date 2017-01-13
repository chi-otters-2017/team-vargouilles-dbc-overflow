get '/questions' do
  @questions = Question.all
  erb :'/questions/index'
end

get '/questions/new' do
  erb :'/questions/_new'
end

post '/questions' do
  question = Question.new(params[:question], author_id: session[:user_id])
  if question.save
    redirect "/questions/#{question.id}"
  else
    @errors = question.errors.full_messages
    erb :'/questions/_new'
  end
end

get '/questions/:id/comments/new' do
  @commentable = Question.find(params[:id])
  erb :"comments/_new"
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  @comments = @question.comments
  erb :'/questions/show'
end

post '/questions/:id/comments' do
  comment_info = {
    body: params[:body],
    commentor_id: session[:user_id],
    commentable_id: params[:id],
    commentable_type: 'Question'

  }

  comment = Comment.new(comment_info)
  if comment.save
    redirect "/questions/#{params[:id]}"
  else
    @errors = comment.errors.full_messages
    @question = Question.find_by(id: params[:id])
    erb :'/questions/show'
  end
end

post '/questions/:id/votes' do
  # raise params[:vote].inspect
  vote_info = {
    voter_id: session[:user_id],
    value: params[:vote],
    votable_id: params[:id],
    votable_type: 'Question'

  }
  new_vote = Vote.new(vote_info)
  if new_vote.save
    redirect "/questions/#{params[:id]}"
  else
    @errors = new_vote.errors.full_messages
    @question = Question.find_by(id: params[:id])
    erb :'/questions/show'
  end
end

# post '/comments/:id/votes' do
#   # raise params[:vote].inspect
#   vote_info = {
#     voter_id: session[:user_id],
#     value: params[:vote],
#     votable_id: params[:id],
#     votable_type: 'Comment'

#   }
#    new_vote = Vote.new(vote_info)
#    if new_vote.save
#     redirect "/questions/#{params[:id]}"
#   else
#     @errors = new_vote.errors.full_messages
#     @question = Question.find_by(id: params[:id])
#     erb :'/questions/show'
#   end
# end
