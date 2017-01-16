get '/questions' do
  @questions = Question.all
  erb :'/questions/index', locals: {:'sort_type' => "Top"}
end

get '/questions/sort/votes' do
  @questions = Question.all.sort_by{|question| question.total_votes}.reverse
  if request.xhr?
  erb :'/questions/index', layout: false, locals: {:'sort_type' => "Top"}
  else
  erb :'/questions/index', locals: {:'sort_type' => "Top"}
  end
end

get '/questions/sort/recent' do
  @questions = Question.all.sort_by{|question| question.created_at}.reverse
  if request.xhr?
  erb :'/questions/index', layout: false, locals: {:'sort_type' => "Most Recent"}
  else
  erb :'/questions/index', locals: {:'sort_type' => "Most Recent"}
  end
end

get '/questions/sort/hot' do
  @questions = Question.all.sort_by{|question| question.updated_at}.reverse
  if request.xhr?
  erb :'/questions/index', layout: false, locals: {:'sort_type' => "Trending"}
  else
  erb :'/questions/index', locals: {:'sort_type' => "Trending"}
  end
end

get '/questions/new' do
  unless logged_in?
    erb :'404'
  else
    if request.xhr?
      erb :'/questions/_new', layout: false
    else
      erb :'questions/_new'
    end
  end
end

post '/questions' do
  @question = Question.new(title: params[:title], content: params[:content], author_id: session[:user_id])
  if @question.save
    if request.xhr?
      erb :"/questions/_question", layout: false, locals: {question: @question}
    else
      redirect "/questions"
    end
  else
    @errors = @question.errors.full_messages
    erb :'/questions/_new'
  end
end

get '/questions/:id' do
  unless logged_in?
    erb :'404'
  else
  @question = Question.find(params[:id])
  @comments = @question.comments
  erb :'/questions/show'
  end
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
    if request.xhr?
      erb :'comments/_show', layout: false, locals: {comment: comment}
    else
      redirect "/questions/#{params[:id]}"
    end

  else
    @errors = comment.errors.full_messages
    @question = Question.find_by(id: params[:id])
    erb :'/questions/show'
  end
end

post '/questions/:id/votes' do
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

