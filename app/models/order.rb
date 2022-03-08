class Order < ApplicationRecord

    enum payment_method: { credit_card: 0, transfer: 1 }
    enum address: { my_address: 0, select_address: 1, new_address: 2 }

end
