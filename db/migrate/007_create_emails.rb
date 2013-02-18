class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.column :from, :string
      t.column :to, :string
      t.column :last_send_attempt, :integer, :default => 0
      t.column :mail, :text
      t.column :created_on, :datetime
      t.column :eflyer_id, :integer
    end
  end

  def self.down
    drop_table :emails
  end
end
