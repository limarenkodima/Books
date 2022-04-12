# frozen_string_literal: true

# Класс определяющий книгу
class Book
  def initialize(id, attributes, relationships)
    @id = id
    @attributes = attributes
    @relationships = relationships
  end

  def last_release
    @attributes['lastReleaseDate']
  end

  def house
    @relationships['publishingHouse']
  end

  def category
    @relationships['category']
  end

  def name
    @attributes['name']
  end

  def authors
    @relationships['authors']
  end

  def price
    @attributes['amountTotal']
  end

  def isbn
    @attributes['isbn']
  end
end
