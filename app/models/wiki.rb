class Wiki < ActiveRecord::Base


  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  scope :visible_to, ->  (user) { user && ((user.role == 'premium') || (user.role == 'admin')) ? all : where(private: false)}

end
