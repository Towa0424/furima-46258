class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id,
                :postal_code, :prefecture_id, :city, :address_line, :building, :phone, :token

  with_options presence: true do
    validates :token
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/} 
    validates :prefecture_id, numericality: { other_than: 1 } 
    validates :city
    validates :address_line    
    validates :phone, format: { with: /\A\d{10,11}\z/}
    validates :user_id
    validates :item_id
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      order_id: order.id,
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address_line: address_line,
      building: building,
      phone: phone
    )
  end
end