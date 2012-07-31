class ProductObserver < ActiveRecord::Observer

  def after_save(model)
    if model.price.changed?
      CartItem.find_all_by_product_id(model.id).each do |cart_item|
        UserMailer.price_changed(cart_item.cart.user, cart_item.product).deliver
      end
    end
  end
end
