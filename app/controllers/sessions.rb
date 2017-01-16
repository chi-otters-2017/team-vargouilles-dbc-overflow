get '/sessions' do
  erb(:'users/_login-form')
end

post '/sessions' do
  login_info = params[:login]
  @user = User.find_by(:email => login_info[:email])
  if @user.authenticate(login_info[:password])
    session[:user_id] = @user[:id]
    redirect "/questions"
  else
    @errors = ['Wrong email or password']
    erb :'/users/new'
  end
end

delete '/sessions' do
  session[:user_id] = nil
  redirect "/questions"
end
