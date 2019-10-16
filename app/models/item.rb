class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :title, presence: true

end
