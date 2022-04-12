# frozen_string_literal: true

require 'json'
require_relative 'book'

# Список книг
class BookList
  attr_reader :blist

  def initialize
    @blist = []
  end

  def read_from_file
    file = File.read('../Books.json')
    data = JSON.parse(file)
    data['books'].each do |book|
      @blist << Book.new(book['id'], book['attributes'],
                         book['relationships'])
    end
  end
end
