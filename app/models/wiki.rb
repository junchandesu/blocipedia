class Wiki < ActiveRecord::Base


  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  scope :get_public_wikis, ->  { where(private: false)}

end
