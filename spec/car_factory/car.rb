AVAILABLE_COLORS = ['Black', 'Red', 'Yellow']

class Car
  @@color_counter = 0

  attr_accessor :brand

  def initialize(brand, params = {})
    @brand = brand.to_s.capitalize!
    @color = params.fetch(:color,
      AVAILABLE_COLORS[@@color_counter]).to_s.gsub('_', ' ').split.map(&:capitalize).join(' ')
    @@color_counter == 2 ? @@color_counter = 0 : @@color_counter += 1
  end

  def color_name
    @color
  end
end
