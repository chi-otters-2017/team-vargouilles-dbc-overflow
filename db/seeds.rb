require 'faker'
40.times do
  username_suffix = ["xxx", "69", "Slayer", "Shadow"]
  user_info = {
    name: Faker::Lorem.word.concat(" #{username_suffix.sample}"),
    email: Faker::Internet.email,
    password: "password"
  }
  User.create(user_info)
end


10.times do
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
    question_id: (1..10).to_a.sample
  }
  Answer.create(answer_info)
end

