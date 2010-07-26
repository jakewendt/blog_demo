class Post < ActiveRecord::Base
  belongs_to :user
  has_many   :comments, :dependent => :destroy #, :order => "body ASC"  #, :order => "created_at ASC"
end
