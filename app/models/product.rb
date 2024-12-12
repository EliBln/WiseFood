class Product < ApplicationRecord
  belongs_to :categorie
  belongs_to :user

  validates :name, presence: true
  validates :expiration_date, presence: true
  validates :quantity_stock, numericality: { greater_than_or_equal_to: 0 }

  def days_remaining
    return 0 if expiration_date.nil?

    days = (expiration_date.to_date - Date.current).to_i
    [days, 0].max  # Retourne 0 si la date est dépassée
  end

  def expiration_color
    days = days_remaining
    if days <= 3
      'bg-danger'
    elsif days <= 5
      'bg-warning-soft' 
    else
      ''
    end
  end
end
