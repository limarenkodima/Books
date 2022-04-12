# frozen_string_literal: true

require 'json'
require_relative 'house'

# Список издательств
class HouseList
  attr_reader :hlist

  def initialize
    @hlist = []
  end

  def read_from_file
    file = File.read('../Books.json')
    data = JSON.parse(file)
    data['publishingHouses'].each do |house|
      @hlist << House.new(house['id'], house['publishingHouse'])
    end
  end
end
