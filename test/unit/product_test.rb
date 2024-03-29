require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "product price must be positive" do 
    product = Product.new(:title => "programming ruby", :description => "great book", :image_url => "/images/ruby.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join('; ')

    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join('; ')

    product.price = 1
    assert product.valid?
    
  end

  def new_product(image_url)
    Product.new(:title => "programming ruby",
                :description => "good book",
                :price => 1,
                :image_url => image_url)
  end

  test "image url" do
    ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
            http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end

  end

  test "product title is invalid without a unique name" do 
    product = Product.new(:title => products(:ruby).title, 
                          :description => "great book", 
                          :price => 49.40,
                          :image_url => "/images/ruby.jpg")
    assert !product.save
    assert_equal "must be have a unique titile name",
      product.errors[:titile].join('; ')
  end

end
