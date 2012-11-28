class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title
  has_many :line_items
  has_many :orders, :through => :line_items

  default_scope :order => 'title'

  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => { :greater_than_or_equal_to => 0.01 }
  validates :title, :uniqueness => true
  validates :image_url, :format => {
                          :with => %r{\.(jpg|png|gif)$}i,
                          :message => 'must be jpg, png of gif'
                        }
  before_destroy :ensure_not_referenced_by_any_line_item

  private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_item.empty?
        return true
      else
        errors.add(:base, 'Line Items Present')      
        return false
      end
    end
end

