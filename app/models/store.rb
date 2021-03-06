class Store < ActiveRecord::Base
  validates_presence_of :street_address, :city, :name, :zip, :user_id
  belongs_to :user
  has_many :products
end
