class CreatePlainTextfield < ActiveRecord::Migration
  def self.up
     add_column :eflyers, :plain_text, :text
  end

  def self.down
    remove_column :eflyers, :plain_text
  end
end
