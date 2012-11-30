require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { description: @product.description, meta_description: @product.meta_description, meta_keywords: @product.meta_keywords, name: @product.name, published_status: @product.published_status, strapline: @product.strapline, subcode: @product.subcode, url_segment: @product.url_segment }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    put :update, id: @product, product: { description: @product.description, meta_description: @product.meta_description, meta_keywords: @product.meta_keywords, name: @product.name, published_status: @product.published_status, strapline: @product.strapline, subcode: @product.subcode, url_segment: @product.url_segment }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
