require 'test_helper'

class VariantsControllerTest < ActionController::TestCase
  setup do
    @variant = variants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:variants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create variant" do
    assert_difference('Variant.count') do
      post :create, variant: { bay: @variant.bay, description: @variant.description, price: @variant.price, product_id: @variant.product_id, sku: @variant.sku, stock_level_reserved: @variant.stock_level_reserved, stock_level_total: @variant.stock_level_total, weight_in_grams: @variant.weight_in_grams }
    end

    assert_redirected_to variant_path(assigns(:variant))
  end

  test "should show variant" do
    get :show, id: @variant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @variant
    assert_response :success
  end

  test "should update variant" do
    put :update, id: @variant, variant: { bay: @variant.bay, description: @variant.description, price: @variant.price, product_id: @variant.product_id, sku: @variant.sku, stock_level_reserved: @variant.stock_level_reserved, stock_level_total: @variant.stock_level_total, weight_in_grams: @variant.weight_in_grams }
    assert_redirected_to variant_path(assigns(:variant))
  end

  test "should destroy variant" do
    assert_difference('Variant.count', -1) do
      delete :destroy, id: @variant
    end

    assert_redirected_to variants_path
  end
end
