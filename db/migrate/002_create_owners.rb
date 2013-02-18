class CreateOwners < ActiveRecord::Migration
  def self.up
    create_table :owners do |t|
      t.column :name, :string
    end
    
     inicial = Owner.new
      inicial.name   = "admin"
      inicial.save 
  end

  def self.down
    drop_table :owners
  end
end
