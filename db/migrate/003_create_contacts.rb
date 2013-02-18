class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.column :name, :string
      t.column :email, :string
      t.column :tester, :boolean
      t.column :active, :boolean
      t.column :category_id, :integer
    end
  end

  def self.down
    drop_table :contacts
  end
end
