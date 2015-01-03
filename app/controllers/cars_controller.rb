class CarsController < ApplicationController

  def index
    @cars = Car.all
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to cars_path, notice: 'Car was successfully created.'
    else
      render :new
    end
  end

  def new
    @car = Car.new
    @Manufacturer = Manufacturer.all
  end

  private
  def car_params
    params.require(:car).permit(:color, :year, :mileage, :description, :manufacturer_id)
  end
end
