require "test_helper"

class QuoteCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quote_category = quote_categories(:one)
  end

  test "should get index" do
    get quote_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_quote_category_url
    assert_response :success
  end

  test "should create quote_category" do
    assert_difference("QuoteCategory.count") do
      post quote_categories_url, params: { quote_category: { category_id: @quote_category.category_id, quote_id: @quote_category.quote_id } }
    end

    assert_redirected_to quote_category_url(QuoteCategory.last)
  end

  test "should show quote_category" do
    get quote_category_url(@quote_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_quote_category_url(@quote_category)
    assert_response :success
  end

  test "should update quote_category" do
    patch quote_category_url(@quote_category), params: { quote_category: { category_id: @quote_category.category_id, quote_id: @quote_category.quote_id } }
    assert_redirected_to quote_category_url(@quote_category)
  end

  test "should destroy quote_category" do
    assert_difference("QuoteCategory.count", -1) do
      delete quote_category_url(@quote_category)
    end

    assert_redirected_to quote_categories_url
  end
end
