class QuoteCategoriesController < ApplicationController
  before_action :set_quote_category, only: %i[ show edit update destroy ]

  # GET /quote_categories or /quote_categories.json
  def index
    @quote_categories = QuoteCategory.all
  end

  # GET /quote_categories/1 or /quote_categories/1.json
  def show
  end

  # GET /quote_categories/new
  def new
    @quote_category = QuoteCategory.new
  end

  # GET /quote_categories/1/edit
  def edit
  end

  # POST /quote_categories or /quote_categories.json
  def create
    @quote_category = QuoteCategory.new(quote_category_params)

    respond_to do |format|
      if @quote_category.save
        format.html { redirect_to @quote_category, notice: "Quote category was successfully created." }
        format.json { render :show, status: :created, location: @quote_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quote_categories/1 or /quote_categories/1.json
  def update
    respond_to do |format|
      if @quote_category.update(quote_category_params)
        format.html { redirect_to @quote_category, notice: "Quote category was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @quote_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quote_categories/1 or /quote_categories/1.json
  def destroy
    @quote_category.destroy!

    respond_to do |format|
      format.html { redirect_to quote_categories_path, notice: "Quote category was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote_category
      @quote_category = QuoteCategory.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def quote_category_params
      params.expect(quote_category: [ :quote_id, :category_id ])
    end
end
