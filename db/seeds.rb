require 'faker'
40.times do
  username_suffix = ["xxx", "69", "Slayer", "Shadow"]
  firstname = Faker::Lorem.word
  user_info = {
    name: firstname.concat("#{username_suffix.sample}"),
    email: Faker::Internet.email,
    password: "password"
  }
  User.create(user_info)
end


20.times do
  question_info = {
  title: Faker::StarWars.vehicle,
  content: Faker::Lorem.sentence,
  author_id: (1..40).to_a.sample
  }
  Question.create(question_info)
end

50.times do
  answer_info = {
    response: Faker::StarWars.quote,
    answerer_id: (1..40).to_a.sample,
    question_id: (1..20).to_a.sample
  }
  Answer.create(answer_info)
end

100.times do
  comment_info = {
    body: Faker::TwinPeaks.quote,
    commentor_id: (1..40).to_a.sample,
    commentable_id: (1..20).to_a.sample,
    commentable_type: ['Question', 'Answer'].sample
  }
  Comment.create(comment_info)
end


100.times do
  vote = {
    voter_id: (1..40).to_a.sample,
    value: [1, -1].sample,
    votable_type: ['Question', 'Answer', 'Comment'].sample,
    votable_id: (1..20).to_a.sample
  }
  Vote.create(vote)
end

