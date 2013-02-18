class CreateEflyers < ActiveRecord::Migration
  def self.up
    create_table :eflyers do |t|
      t.column :costumer, :string
      t.column :name, :string
      t.column :subject, :string
      t.column :from, :string
      t.column :link, :string
      t.column :email, :string
      t.column :body, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :hold, :boolean
      t.column :delivered_to, :integer, :default => 0
      t.column :format, :integer, :default => 1
      t.column :owner_id, :integer
      t.column :category_id, :integer
      
      
     
    end
  end

  def self.down
    drop_table :eflyers
  end
end
