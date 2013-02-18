class User < ActiveRecord::Base
  attr_writer :t 
  
  def password=(pass) 
  salt = [Array.new(56){rand(256).chr}.join].pack("m").chomp 
  self.salt, self.hass = 
  salt, Digest::SHA256.hexdigest(pass + salt) 
  end 
  
  def self.authenticate(login, password) 
   user = User.find(:first, :conditions => ['login = ?', login]) 
   if user.blank? || Digest::SHA256.hexdigest(password + user.salt) != user.hass 
     user = nil
   else
     user    
   end
  end
  
  
  
end