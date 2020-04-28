class Category < ApplicationRecord
  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Category', optional: true
  has_and_belongs_to_many :products
  has_many :subproducts, through: :subcategories, source: :products

  def all_products
    self.products | self.subproducts
  end

  def self.all_parents
    self.where(parent: nil)
  end

end
