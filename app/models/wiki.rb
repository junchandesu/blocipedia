class Wiki < ActiveRecord::Base


  
  has_many :collaborators
  has_many :users, through: :collaborators
  # belongs_to :user


  validates :title, presence: true
  validates :body, presence: true

  # scope :visible_to, ->  (user) { user && ((user.role == 'premium') || (user.role == 'admin')) ? where(private: true, user: user)+ where(private: false) + where(private: nil) : where(private: false) + where(private: nil) }

  # def self.visible_to(user)
  # 	wikis = []
  # 	if user.admin? || user.premium?
  # 		wikis = Wiki.all
  # end
end
