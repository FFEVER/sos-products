class Product < ApplicationRecord
  has_and_belongs_to_many :categories

  validates :user_id, presence: true
  validates :title, presence: true, length: {minimum: 1, maximum: 150}
  validates :long_desc, presence: true, length: {minimum: 1, maximum: 2000}
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 1_000_000}
  validates :stock, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 1_000_000}
  validates :categories, presence: true

  paginates_per 15

  def category_tree
    return {} if categories.blank?

    category = categories.first
    if category.parent
      parent = category.parent.attributes
      parent['subcategories'] = category.attributes
    else
      parent = category.attributes
      parent['subcategories'] = {}
    end
    parent
  end

  def category_id=(id)
    return unless Category.exists? id: id

    categories.destroy_all
    categories << Category.find(id)
  end

  def checkout(quantity)
    if quantity.instance_of?(Integer)
      self.sold_quantity += quantity
      self.stock -= quantity
      save
    else
      errors.add(:sold_quantity, "type must be integer.")
      false
    end
  end


end
