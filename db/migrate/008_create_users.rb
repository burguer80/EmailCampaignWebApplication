class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
        t.column :login, :string
        t.column :salt, :string
        t.column :hass, :string
      
    end
        inicial = User.new
      inicial.login     = "admin"
      inicial.password = "adminadminadmin"
      inicial.save 
  end

  def self.down
    drop_table :users
   
     
    
  end
end
