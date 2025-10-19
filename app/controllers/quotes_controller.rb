class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show edit update destroy]
  before_action :require_login, only: %i[new create edit update destroy my_quotes]
  before_action :authorize_user, only: %i[edit update destroy]

  # GET /quotes or /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/my_quotes
  def my_quotes
    # Fetch all quotes belonging to the logged-in user
    @quotes = current_user.quotes
  end

  # GET /quotes/1 or /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params)
    @quote.user = current_user # Ensure quote is linked to logged-in user

    # Ensure the selected categories are saved with the quote
    @quote.category_ids = params[:quote][:category_ids] if params[:quote][:category_ids]

    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: "Quote was successfully created." }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        # Update categories when updating the quote
        @quote.category_ids = params[:quote][:category_ids] if params[:quote][:category_ids]

        format.html { redirect_to @quote, notice: "Quote was successfully updated." }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy

    respond_to do |format|
      format.html { redirect_to quotes_path, status: :see_other, notice: "Quote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Ensure user is logged in
    def require_login
      unless logged_in?
        redirect_to login_path, alert: "You must be logged in to perform this action."
      end
    end

    # Ensure the user is authorized to edit, update, or delete their own quote
    def authorize_user
      unless @quote.user == current_user || is_administrator?
        redirect_to quotes_path, alert: "You are not authorized to perform this action."
      end
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      params.require(:quote).permit(:quote_text, :pub_year, :comment, :is_public, :user_id, :philosopher_id, category_ids: [])
    end
end
