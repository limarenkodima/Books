# frozen_string_literal: true

require 'json'
require_relative 'author'

# Список авторов
class AuthorList
  attr_reader :alist

  def initialize
    @alist = []
  end

  def read_from_file
    file = File.read('../Books.json')
    data = JSON.parse(file)
    data['internalAuthors'].each do |author|
      @alist << Author.new(author['id'], author['authorName'],
                           author['letter'])
    end
  end
end
