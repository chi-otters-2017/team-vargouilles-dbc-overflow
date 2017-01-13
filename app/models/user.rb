require 'bcrypt'
class User < ActiveRecord::Base
  validates :email, :name, {presence: true}
  include BCrypt

  has_many :authored_questions, { class_name: 'Question', foreign_key: :author_id }



  def password
    @password ||= Password.new(hashed_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.hashed_password = @password
  end

  def authenticate(password_input)
    self.password == password_input
  end
end
