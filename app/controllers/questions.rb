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

get '/questions/:id' do
  @question = Question.find_by(id: params[:id])
  @comments = @question.comments
  erb :'/questions/show'
end

get '/questions/:id/comments/new' do
  @commentable = Question.find(id: params[:id])
  erb :"comments/_new"
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
