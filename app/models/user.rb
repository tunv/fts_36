class User < ActiveRecord::Base
  has_many :exams, dependent: :destroy

  FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: Settings.user.maximum}
  validates :email, format: {with: FORMAT}, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.user.minimum}
  validates :password_confirmation, presence: true
end
