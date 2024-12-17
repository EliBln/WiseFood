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
      'bg-dangerx'  # Rouge pour 3 jours ou moins
    elsif days <= 5
      'bg-warning-soft' # Orange doux pour 4-5 jours
    else
      '' # Blanc (pas de classe) pour plus de 5 jours
    end
  end

  def expired?
    days_remaining == 0
  end



private

def set_default_position
  self.position = (Product.maximum(:position) || 0) + 1
end

end
