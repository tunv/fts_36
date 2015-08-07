class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  devise :database_authenticatable, :registerable,:rememberable,
    :validatable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :exams, dependent: :destroy
  validates_format_of :email, without: TEMP_EMAIL_REGEX, on: :update
  validates :name, presence: true, length: {maximum: 60}

  before_create :set_default_role

  enum role: [:normal, :admin]
  def self.find_for_oauth(auth, signed_in_resource = nil)
   identity = Identity.find_for_oauth(auth)

    user = signed_in_resource ? signed_in_resource : identity.user
    if user.nil?
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.save!
      end
    end
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  private
  def set_default_role
    self.role ||= :normal
  end

  def self.import file
    spreadsheet = open_spreadsheet file
    header = spreadsheet.row 1
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      user = find_by(email: row["email"]) || new
      user.attributes = row.to_hash.slice *row.to_hash.keys
      user.save!
    end
  end

  def self.open_spreadsheet file
    if File.extname file.original_filename
      Roo::CSV.new file.path
    else
      raise I18n.t("import_fail") + "#{file.original_filename}"
    end
  end

  def self.to_csv options = {}
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end
end
