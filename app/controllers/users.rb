get '/users/new' do
  erb :'/users/new'
end

post '/users' do
  user = User.new(params[:user])
  if user.save
    redirect "/users/#{user.id}"
  else
    @errors = user.errors.full_messages
    erb :'users/new'
  end
end

get '/users/:user_id' do
  @user = User.find_by(id: session[:user_id])
  erb :'users/show'
end


