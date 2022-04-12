# frozen_string_literal: true

# Класс определяющий издательство
class House
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end
end
