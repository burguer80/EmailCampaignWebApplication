class AddConfirmation < ActiveRecord::Migration
  def self.up
  
    add_column :contacts, :confirmation, :string
    
    
     contacts = Contact.find(:all)
    
    for contact in contacts
    contact.confirmation = Digest::SHA1.hexdigest("--#{Time.now.to_s}-#{contact.email}---")[0,6]
     contact.save
    end 
    end

  def self.down
    remove_column :contacts, :confirmation
  end
end
