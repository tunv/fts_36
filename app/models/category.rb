class Category < ActiveRecord::Base
  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :name, presence: true, 
    length: {minimum: Settings.user.minimum, maximum: Settings.user.maximum},
    uniqueness: true
  validates :max_question, presence: true, numericality: {only_integer: true}
  validates :max_time, presence: true, numericality: {only_integer: true}
end
