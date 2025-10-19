class Category < ApplicationRecord
    has_many :quote_categories, dependent: :destroy
    has_many :quotes, through: :quote_categories
end
