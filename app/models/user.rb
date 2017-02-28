class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         # , :authentication_keys => [:login]
  
  # this allows login by username or email id
  attr_accessor :login
  
  validates :first_name, length: {minimum: 1, maximum: 15}, presence: true #, message: 'Require First Name'
  validates :last_name, length: {minimum: 1, maximum: 15}, presence: true #, message: 'Require Last Name' 
  validates :user_name, presence: true, format: { with: /\A[a-zA-Z0-9]+\z/, 
    message: "only allows letters / numbers and no blank space" }, 
    :uniqueness => { :case_sensitive => false}
  
   
  has_many :attendance
  
  def login=(login)
      @login = login
  end

  def login
    @login || self.user_name || self.email
  end
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(user_name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:user_name) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
  end
    
end
