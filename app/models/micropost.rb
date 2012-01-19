class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true

  default_scope :order => "microposts.created_at DESC"

  def self.from_users_followed_by(user)
    users = Array.new(user.following)
    users.push(user)
    where(:user_id => users)  
  end
end
