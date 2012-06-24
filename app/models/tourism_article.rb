class TourismArticle < ActiveRecord::Base

  belongs_to :user
  has_many :comments, as: :commentable

  attr_accessible :content, :title, :video, :image, :user_id, as: [:default] + User.valid_roles
  has_attached_file :image, :styles => { 
    :large => "740x380#",
    :medium => "340x180#",
    :tiny => "240x180#",
    :small => "100x100#",
    :thumb => "145x75#"
  }

  validates :title, :content, :presence => true
end
