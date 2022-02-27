class Item < ApplicationRecord
    validates :name, presence: true
    validates :introduction, presence: true


    def with_tax_price
        (price * 1.1).floor
    end
end
