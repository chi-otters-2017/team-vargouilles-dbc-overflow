get '/users/new' do
  erb :'/users/_new'
end

post '/users' do
  user = User.new(params[:user])
  if user.save
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    @errors = user.errors.full_messages
    erb :'users/_new'
  end
end

get '/users/:user_id' do
  @user = User.find_by(id: session[:user_id])
  erb :'users/show'
end



