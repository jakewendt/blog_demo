class CreateUserLastLogin < ActiveRecord::Migration
  def self.up
    add_column :users, :last_login, :datetime, :default => 0
  rescue
    puts "last_login already exists, but that's ok"
  end

  def self.down
    remove_column :users, :last_login
  end
end
