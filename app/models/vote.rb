class Vote < ActiveRecord::Base
  attr_accessible :user_id, :voteable_id

  belongs_to :user
  belongs_to :voteable, :polymorphic => true
  
  validates_uniqueness_of :voteable_id, :scope => :user_id
  validates_inclusion_of :value in: [1, -1]
  validate :not_the_author
  
  def not_the_author
    errors.add :user_id, "is the author" if voteable.user_id == user_id
  end
  

end
