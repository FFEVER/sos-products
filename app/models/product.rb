class Product < ApplicationRecord
    has_and_belongs_to_many :categories

    def category_tree
        category = self.categories.first
        if category.parent
            parent = category.parent.attributes
            parent["subcategories"] = category.attributes
        else
            parent = category.attributes
            parent["subcategories"] = {}
        end
        parent
    end

end
