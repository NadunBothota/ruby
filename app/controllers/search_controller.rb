class SearchController < ApplicationController
  def index
    quote_query = params[:quote_query]

    if quote_query.present?
      @quotes = Quote.joins(:philosopher, :categories)
                     .where("quote_text LIKE :query 
                             OR philosophers.phil_first_name LIKE :query 
                             OR philosophers.phil_last_name LIKE :query 
                             OR categories.category_name LIKE :query", 
                            query: "%#{quote_query}%")
                     .distinct
    else
      @quotes = Quote.none  # Return empty results if no query is given
    end
  end
end

