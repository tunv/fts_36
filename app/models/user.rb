class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  has_many :exams, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.user.maximum}

  before_create :set_default_role

  enum role: [:normal, :admin]

  private
  def set_default_role
    self.role ||= :normal
  end
end
