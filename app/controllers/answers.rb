get '/questions/:id/answers/new' do
  erb :"answers/_new"
end

post '/questions/:id/answers' do
  @user = User.find(session[:user_id])
  @answer = Answer.new(response: params[:response], answerer_id: session[:user_id], question_id: params[:id])
  if @answer.save
    @votes = @answer.total_votes
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
