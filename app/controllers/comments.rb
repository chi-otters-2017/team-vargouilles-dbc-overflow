get '/questions/:id/comments/new' do
  unless logged_in?
    erb :'404'
  else
    @commentable = Question.find(params[:id])
    if request.xhr?
      erb :"comments/_new", layout: false
    else
      erb :"comments/_new"
    end
  end
end

get '/answers/:id/comments/new' do
  unless logged_in?
    erb :'404'
  else
    @commentable = Answer.find(params[:id])
    if request.xhr?
      erb :"comments/_new", layout: false
    else
      erb :"comments/_new"
    end
  end
end

post '/comments/:id/votes' do
  vote_info = {
    voter_id: session[:user_id],
    value: params[:vote],
    votable_id: params[:id],
    votable_type: 'Comment'
  }

  @comment = Comment.find(params[:id])
  new_vote = Vote.new(vote_info)

  if new_vote.save
    puts "Made it past save."
    redirect "/questions/#{@comment.parent_question.id}"
  else
    @errors = new_vote.errors.full_messages
    @question = Question.find(@comment.parent_question.id)
    erb :'/questions/show'
  end
end

