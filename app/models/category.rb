class Category < ActiveRecord::Base
  has_and_belongs_to_many :zones
  has_many :contacts
  validates_presence_of :name
  validates_uniqueness_of :name
  
  
end
