require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "Product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "Product price must be positive" do
    product = Product.new(
      title: "My book title",
      description: "zzzz",
      image_url: "zzzz.png"
    )
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0.01
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(
      title: 'My book title',
      description: 'zzzz',
      image_url: image_url,
      price: 1
    )
  end

  test "image URL" do
    ok = %w{ frank.jpeg perfwer.png ergkwhergkufwe.Jpg }
    bad = %w{ frank.doc perfwer.xl ergkwhergkufwe.word }

    ok.each do |image_url|
      assert new_product(image_url).valid?
    end
    bad.each do |image_url|
      assert new_product(image_url).invalid?
    end
  end

  test "product is now valid without a unique title" do
    product = Product.new(
      title: products(:ruby).title,
      description: 'zzzz',
      image_url: 'ridocker.jpg',
      price: 1
    )
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end


end
