class Exam < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :questions, through: :results
  has_many :results, dependent: :destroy

  before_create :create_default_status
  after_create :create_results

  accepts_nested_attributes_for :results, allow_destroy: true

  scope :order_created, ->{order created_at: :desc}
  scope :other_exam, ->exam_id{where.not id: exam_id}

  enum status: [:created, :testing, :completed]

  def update_start_time time
    update_attributes start_at: time
  end

  def update_status status
    update_attributes status: status
  end

  private
  def create_default_status
    self.status = :created
  end

  def create_results
    @questions = category.questions.random_questions category.max_question
    @questions.each {|question| results.create question: question}
  end
end
