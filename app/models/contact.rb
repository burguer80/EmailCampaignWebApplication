class Contact < ActiveRecord::Base
  belongs_to :category, :counter_cache => true
#  
 # validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
#

  validates_presence_of :email
  validates_uniqueness_of :email, :confirmation 
  

  
end
