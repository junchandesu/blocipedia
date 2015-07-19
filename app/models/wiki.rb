class Wiki < ActiveRecord::Base


  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  validates :title, presence: true
  validates :body, presence: true

  scope :visible_to, ->  (user) { user && ((user.role == 'premium') || (user.role == 'admin')) ? user.wikis.where(private: true) + where(private: false) : where(private: false) + where(private: nil) }

end
