class Photo < ActiveRecord::Base
  belongs_to :eflyer
  
  has_attachment :content_type => ['application/x-shockwave-flash', :image], 
                 :storage => :file_system, 
                 :max_size => 500.kilobytes,
                # :thumbnails => { :thumb => '100x100>' },                
                 :processor => :MiniMagick,
                 :size => 0.megabyte..2.megabytes
                 #:resize_to => '320x200>'
               

  validates_as_attachment
end
