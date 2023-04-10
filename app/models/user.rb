class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_and_belongs_to_many :posts, dependent: :destroy, join_table: :posts_users
  has_many :commentratings, dependent: :destroy
  has_many :comments, through: :commentratings, dependent: :destroy
  after_create :send_signup_email

  def send_signup_email
    SendSignupEmailJob.perform_later(self)
  end
end
