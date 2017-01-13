# We no longer need this because the partial for adding a new answer has been added to the question page

# get '/questions/:id/answers/new' do
#   erb :"answers/_new"
# end

post '/questions/:id/answers' do
  @question = Question.find(params[:id])
  @user = User.find(session[:user_id])
  @answer = Answer.new(response: params[:response], answerer_id: session[:user_id], question_id: params[:id])
  if @answer.save
    # this doesn't work
    @votes = @answer.total_votes
    redirect "/questions/#{params[:id]}"
    if request.xhr?
      erb :"/answers/_show", layout: false
    else
      redirect :'/questions/:id'
    end
  else
    @errors = @answer.errors.full_messages
    erb :"/answers/_new"
  end
end

get '/answers/:id/comments/new' do
  @commentable = Answer.find(params[:id])
  erb :'/comments/_new'
end

 # FIX THIS
post '/answers/:id/comments' do
  @answer_comment = Comment.new(commentor_id: session[:user_id, ])

end

