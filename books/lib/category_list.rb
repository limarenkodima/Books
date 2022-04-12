# frozen_string_literal: true

require 'json'
require_relative 'category'

# Список категорий книг
class CategoryList
  attr_reader :clist

  def initialize
    @clist = []
  end

  def read_from_file
    file = File.read('../Books.json')
    data = JSON.parse(file)
    data['categories'].each do |category|
      @clist << Category.new(category['id'], category['categoryName'])
    end
  end
end
