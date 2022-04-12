# frozen_string_literal: true

require 'tty-prompt'
require_relative 'book_list'
require_relative 'category_list'
require_relative 'author_list'
require_relative 'house_list'

class PromtMenu
  @blist = BookList.new
  @clist = CategoryList.new
  @alist = AuthorList.new
  @hlist = HouseList.new
  @alphabet = %w[А Б В Г Д Е Ё Ж З И Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Щ Ъ Ы Ь Э
                 Ю Я]
  @prompt = TTY::Prompt.new
  @first_menu_choises = ['Выбрать букву из алфавита',
                         'Завершить работу приложения']
  @second_menu_choises = ['Выбрать автора', 'Вернуться к списку букв']
  @third_menu_choises = ['Начать поиск заново',
                         'Выбрать другого автора на эту же букву', 'Выйти из приложения']

  def self.read_all
    @blist.read_from_file
    @clist.read_from_file
    @alist.read_from_file
    @hlist.read_from_file
  end

  def self.main
    read_all
    first_menu
  end

  def self.first_menu
    loop do
      ans = @prompt.enum_select('Выберите номер услуги',
                                @first_menu_choises, per_page: 2)
      case ans
      when @first_menu_choises[0]
        alphabet_menu
      when @first_menu_choises[1]
        abort
      end
    end
  end

  def self.second_menu(authors)
    loop do
      ans = @prompt.enum_select('Выберите номер услуги',
                                @second_menu_choises, per_page: 2)
      case ans
      when @second_menu_choises[0]
        authors_menu(authors)
      when @second_menu_choises[1]
        first_menu
      else
        return
      end
    end
  end

  def self.third_menu(authors)
    loop do
      ans = @prompt.enum_select('Выберите номер услуги',
                                @third_menu_choises, per_page: 3)
      case ans
      when @third_menu_choises[0]
        first_menu
      when @third_menu_choises[1]
        second_menu(authors)
      when @third_menu_choises[2]
        abort
      else
        return
      end
    end
  end

  def self.alphabet_menu
    loop do
      ans = @prompt.enum_select('Алфавит', @alphabet, per_page: 33)
      authors = get_authors(ans)
      second_menu(authors)
    end
  end

  def self.authors_menu(authors)
    loop do
      ans = @prompt.enum_select('Выберите автора', authors,
                                per_page: authors.size)

      author = find_author_by_name(ans)
      count = 0
      count1 = 0
      co_authors = []
      @blist.blist.each do |item|
        count += 1 if item.authors.include?(author)
        next unless item.authors.include?(author) && item.authors.size > 1

        count += 1
        item.authors.each do |co_author|
          co_authors << co_author unless co_authors.include?(co_author)
        end
      end
      puts "Количество книг данного автора, которые есть в настоящий момент в приложении: #{count}"
      puts "Количество книг данного автора, которые были написаны в соавторстве: #{count1}"
      co_authors.each do |item|
        puts "Список уникальных имён соавторов #{item.name}"
      end
      third_menu(authors)
    end
  end

  def self.print_alphabet
    @alphabet.each_index { |i| print "#{i}-#{@alphabet[i]} " }
    puts ''
  end

  def self.get_authors(symbol)
    authors_result_list = []
    @alist.alist.each do |item|
      authors_result_list << item.name if item.name.chr == symbol
    end
    authors_result_list.sort
  end

  def self.print_authors(authors, symbol)
    if authors.empty?
      puts "Нет авторов, фамилия которых начинается на букву #{symbol}"
      first_menu
    end
    puts 'Список авторов: '
    authors.each_index do |i|
      puts "#{i}-#{authors[i]}"
    end
  end

  def self.find_author_by_name(author_name)
    @alist.alist.each do |item|
      return item if item.name == author_name
    end
  end
end
