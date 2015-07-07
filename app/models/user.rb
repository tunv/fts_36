class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  has_many :exams, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.user.maximum}
end
