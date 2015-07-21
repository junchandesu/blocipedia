class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

   has_many :wikis
   has_many :collaborators
   has_many :wikis, through: :collaborators   

   validates :name, presence: true, uniqueness: true 

   after_initialize :default_standard

   def standard?
   		role == 'standard'
   end

   def premium?
   		role == 'premium'
   end

   def admin?
   	role == 'admin'
   end

    def default_standard
     self.role ||= "standard"
  end
end


class Amount
  def default
   return 10_00
  end
end