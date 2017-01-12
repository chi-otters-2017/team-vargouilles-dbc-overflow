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
  @comments = @question
  erb :'/questions/show'
end

