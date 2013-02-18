class Eflyer < ActiveRecord::Base
  has_one :photo, :dependent => :destroy
end
