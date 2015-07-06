class Question < ActiveRecord::Base
  belongs_to :category

  has_many :exams, through: :results
  has_many :results, dependent: :destroy
  has_many :answers, dependent: :destroy

  validates :content, presence: true, length: {maximum: Settings.user.maximum}
  validates :category_id, presence: true
end
