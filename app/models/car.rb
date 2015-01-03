class Car < ActiveRecord::Base
  belongs_to :manufacturer

  validates :manufacturer_id,
  presence: true
  validates :color,
  presence: true
  validates :mileage,
  presence: true
  validates :year,
  presence: true,
  :numericality => { :greater_than => 1920, :less_than_or_equal_to =>2200 }

end
