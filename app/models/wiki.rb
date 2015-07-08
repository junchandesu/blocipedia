class Wiki < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  scope :visible_to, ->  { where(private: false)}
end
