class CarPark
  def initialize(number_of_places)
    @number_of_places = number_of_places
    @cars_at_park = []
  end

  def capacity
    @number_of_places
  end

  def receive(params)
    if params.is_a?(Array)
      number_of_cars = params.size
      params.pop(number_of_cars - @number_of_places) if number_of_cars > @number_of_places
      @cars_at_park.concat(params)
    else
      @cars_at_park << params
    end
  end

  def cars
    @cars_at_park
  end

  def places_left
    @number_of_places - @cars_at_park.size
  end

  def retrieve(quantity)
    @cars_at_park.pop(quantity)
  end

  def brands
    @cars_at_park.map(&:brand).uniq
  end

  def brands_stats
    stats = Hash.new(0)
    @cars_at_park.map(&:brand).each { |brand| stats[brand] += 1 }
    stats
  end
end
