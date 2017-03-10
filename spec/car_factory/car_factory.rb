require 'car_factory/car'

POSSIBLE_BRANDS = ['Fiat', 'Lancia', 'Ford', 'Subaru']

class CarFactory
  def initialize(name, brands:)
    @name = name
    @brands = []
    @brands << brands
    @brands.flatten!
    @humanized_brands = []

    @brands.each { |brand| @humanized_brands << brand.to_s.capitalize! }

    @humanized_brands.each do |humanized_brand|
      unless POSSIBLE_BRANDS.include?(humanized_brand)
        raise CarFactory::UnsupportedBrandException, "Brand not supported: '#{humanized_brand}'"
      end
    end
  end

  def make_car(*brand)
    brand = brand.first

    if @brands.size == 1 && brand.nil?
      @brands.each do |factory_brand|
        return Car.new(factory_brand)
      end
    elsif @brands.include?(brand)
      return Car.new(brand)
    else
      raise CarFactory::UnsupportedBrandException, "Factory does not have a brand or do not support it"
    end
  end

  def name
    "#{@name} (produces #{@humanized_brands.join(', ')})"
  end

  def make_cars(params)
    cars = []
    counter = 0

    if params.is_a?(Fixnum)
      params.times do
        cars << make_car(@brands[counter])
        counter == @brands.size - 1 ? counter = 0 : counter += 1
      end
    else
      params.map do |param|
        brand = param.first
        quantity = param.last
        @brands.include?(brand) ? quantity.times { cars << make_car(brand) } : next
      end
    end

    cars
  end

  class UnsupportedBrandException < StandardError;
  end
end
