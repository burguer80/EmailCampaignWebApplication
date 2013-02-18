class CreateZones < ActiveRecord::Migration
  def self.up
    create_table :zones do |t|
      t.column :name, :string
      
    end
  
   create_table(:categories_zones, :id => false) do |t|
   t.column :category_id, :integer
   t.column :zone_id, :integer
 end
 
    add_column :categories, :contacts_count, :integer, :default => 0

  
  end

  def self.down
    drop_table :zones
   drop_table :categories_zones
   remove_column(:categories, :contacts_count)
  end
end
