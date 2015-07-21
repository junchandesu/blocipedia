class Wiki < ActiveRecord::Base


  
  has_many :collaborators
  has_many :users, through: :collaborators
  belongs_to :user


  validates :title, presence: true
  validates :body, presence: true

  scope :visible_to, ->  (user) { user && ((user.role == 'premium') || (user.role == 'admin')) ? all : where(private: false) + where(private: nil) }

end
