class AddActivatedEmail < ActiveRecord::Migration
  def self.up
    add_column :users, :activated_email, :string
  rescue
    puts "activated_email already exists, but that's ok"
  end

  def self.down
    remove_column :users, :activated_email
  end
end
