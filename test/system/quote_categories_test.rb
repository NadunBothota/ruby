require "application_system_test_case"

class QuoteCategoriesTest < ApplicationSystemTestCase
  setup do
    @quote_category = quote_categories(:one)
  end

  test "visiting the index" do
    visit quote_categories_url
    assert_selector "h1", text: "Quote categories"
  end

  test "should create quote category" do
    visit quote_categories_url
    click_on "New quote category"

    fill_in "Category", with: @quote_category.category_id
    fill_in "Quote", with: @quote_category.quote_id
    click_on "Create Quote category"

    assert_text "Quote category was successfully created"
    click_on "Back"
  end

  test "should update Quote category" do
    visit quote_category_url(@quote_category)
    click_on "Edit this quote category", match: :first

    fill_in "Category", with: @quote_category.category_id
    fill_in "Quote", with: @quote_category.quote_id
    click_on "Update Quote category"

    assert_text "Quote category was successfully updated"
    click_on "Back"
  end

  test "should destroy Quote category" do
    visit quote_category_url(@quote_category)
    click_on "Destroy this quote category", match: :first

    assert_text "Quote category was successfully destroyed"
  end
end
