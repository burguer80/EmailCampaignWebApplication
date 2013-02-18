class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
       t.column :name, :string
    end
       inicial = Category.new
      inicial.name   = "personal"
      inicial.save 
    
  end

  def self.down
    drop_table :categories
  end
end
