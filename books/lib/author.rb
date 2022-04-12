# frozen_string_literal: true

# Класс определяющий одного автора
class Author
  attr_reader :name, :id

  def initialize(id, name, letter)
    @id = id
    @name = name
    @letter = letter
  end
end
