require_relative 'item'

class Item

  def initialize(*)
    raise "Cannot create Item directly."
  end

  def init(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def before_sell_in?
    @sell_in >= 0
  end

  def update_item_sell_in
    @sell_in -= 1
  end

  def increase_item_quality(amount)
    @quality = [@quality + amount, 50].min
  end

  def decrease_item_quality(amount)
    @quality = [@quality - amount, 0].max
  end

end

class Generic < Item

  def initialize(name, sell_in, quality)
    init(name, sell_in, quality)
  end

  def update_quality
    update_item_sell_in
    decrease_item_quality(before_sell_in? ? 1 : 2)
  end

end

class Brie < Item

  def initialize(name, sell_in, quality)
    init(name, sell_in, quality)
  end

  def update_quality
    update_item_sell_in
    increase_item_quality(before_sell_in? ? 1 : 2)
  end

end

class Sulfuras < Item

  def initialize(name, sell_in, quality)
    init(name, sell_in, quality)
  end

  def update_quality
    # do nothing!
  end

end

class Passes < Item

  def initialize(name, sell_in, quality)
    init(name, sell_in, quality)
  end

  def update_quality
    update_item_sell_in
    case @sell_in.clamp(0, 12)
    when 0
      @quality = 0
    when 1..5
      increase_item_quality(3)
    when 6..11
      increase_item_quality(2)
    when 12
      increase_item_quality(1)
    end
  end

end

class Conjured < Item

  def initialize(name, sell_in, quality)
    init(name, sell_in, quality)
  end

  def update_quality
    update_item_sell_in
    decrease_item_quality(before_sell_in? ? 2 : 4)
  end

end

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item.update_quality
    end
  end

end
