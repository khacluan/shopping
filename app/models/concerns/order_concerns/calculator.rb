module OrderConcerns
  module Calculator
    extend ActiveSupport::Concern

    def calculate_total_price
      calculate_subtotal_price
      calculate_shipping_price
      calculate_discounted_price
      calculate_tax_price
      self.total_price = self.subtotal_price + self.shipping_price + self.discounted_price + self.tax_price
    end

    private

    def calculate_subtotal_price
      self.subtotal_price = line_items.sum("quantity * price")
    end

    def calculate_shipping_price
      self.shipping_price = 0
    end

    def calculate_tax_price
      self.tax_price = 0
    end

    def calculate_discounted_price
      self.discounted_price = 0
    end

  end
end
