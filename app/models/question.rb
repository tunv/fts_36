class Question < ActiveRecord::Base
  belongs_to :category

  has_many :exams, through: :results
  has_many :results, dependent: :destroy
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: :all_blank

  validates :content, presence: true, length: {maximum: Settings.user.maximum}
  validates :category_id, presence: true

  scope :random_questions, ->number{limit(number).sort_by{rand}}
end
