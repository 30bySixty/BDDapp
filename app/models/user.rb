class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :exercises
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  self.per_page = 2
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def self.search_by_name(name)
    names_array = name.split(' ') #split by space in case someone enters "Firstname Lastname", separate by space
    if names_array.size == 1 #if only one name
      where('first_name LIKE ? or last_name LIKE ?', 
        "%#{names_array[0]}%", "%#{names_array[0]}%").order(:first_name)
    else
  where('first_name LIKE ? or first_name LIKE ? or last_name LIKE ? or last_name LIKE ?', 
    "%#{names_array[0]}%", "%#{names_array[1]}%", "%#{names_array[0]}%", "%#{names_array[1]}%").order(:first_name)
    end
  end
  
end
