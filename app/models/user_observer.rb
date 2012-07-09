class UserObserver < ActiveRecord::Observer
  def after_create(model)
    Cart.create!(user_id: model.id)
  end
end
