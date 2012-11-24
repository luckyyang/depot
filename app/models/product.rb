class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title
  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => { :greater_than_or_equal_to => 0.01 }
  validates :title, :uniqueness => true
  validates :image_url, :format => {
                          :with => %r{\.(jpg|png|gif)$}i,
                          :message => 'must be jpg, png of gif'
                        }
end
