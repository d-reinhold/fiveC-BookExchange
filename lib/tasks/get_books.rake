# encoding: utf-8
require 'nokogiri'
require 'open-uri'

namespace :db do
  desc "Goes through the course database and scrapes Huntley for the required books."
  task :get_books => :environment do
    huntley_base_url = "http://www.bkstr.com/webapp/wcs/stores/servlet/booklookServlet?bookstore_id-1=994&term_id-1=FA2012"
    no_course_book = Book.where('title =?', 'Could not find the specified course.').first
    no_course_book ||= Book.create!(:title => 'Could not find the specified course.')
    no_materials_book = Book.where('title =?', 'No books needed for this class.').first
    no_materials_book ||= Book.create!(:title => 'No books needed for this class.')
    not_finalized_book = Book.where('title =?', 'Materials not finalized for this class.').first
    not_finalized_book ||= Book.create!(:title => 'Materials not finalized for this class.')
    #options_book = Book.where('title =?', 'This course has options for required books.').first
    #options_book ||= Book.create!(:title => 'This course has options for required books.')
    recommended_book = Book.where('title =?', 'This course has optional materials.').first
    recommended_book ||= Book.create!(:title => 'This course has optional materials.')
    bundled_book = Book.where('title =?', 'This course has a bundle available.').first
    bundled_book ||= Book.create!(:title => 'This course has a bundle available.')
    Course.all.each do |course|
      puts 'School: ' + course.school_symbol
      puts 'Department: ' + course.department
      puts 'Number: ' + course.number
      puts 'Name: ' + course.name
      puts 'Prof: ' + course.prof
      puts 'Section: ' + course.section
      #begin
        puts huntley_base_url+'&div-1='+course.school_symbol+'&dept-1='+course.department+'&course-1='+course.number+'&section-1='+course.section+'#content'
        bookstore = Nokogiri::HTML(open(huntley_base_url+'&div-1='+course.school_symbol+'&dept-1='+course.department+'&course-1='+course.number+'&section-1='+course.section+'#content'))
        if bookstore.css('.results h2.error')[0]
          course.books.destroy_all
          if bookstore.css('.results h2.error')[0].text.include?("No Course Materials Required For This Course")
            course.books << no_materials_book
            puts "No books needed for this class: " + course.name
          elsif bookstore.css('.results h2.error')[0].text.include?("To Be Determined")
            course.books << not_finalized_book
            puts "Materials not finalized for this class: " + course.name
          else
            course.books << no_course_book
            puts 'Could not find the specified course: ' + course.name
          end
        elsif bookstore.css('.results h3.paddingChoice')[0] and bookstore.css('h2').select{|s| s.text.include?("RECOMMENDED")}.any?
          #if bookstore.css('.paddingLeft5em li').select{|s| s.text.include?("FORMAT")}.any?
          #  course.books.destroy_all
          #  course.books << formatted_book
          #  puts "This course has multiple formats for books: " + course.name 
          course.books.destroy_all
          course.books << recommended_book
          puts "This course has optional materials: " + course.name
        elsif bookstore.css('.results h3.paddingChoice')[0]  and bookstore.css('h3.paddingChoice').select{|s| s.text.include?("BUNDLED")}.any?
          course.books.destroy_all
          course.books << bundled_book
          puts "This course has a bundle available: " + course.name
          #else 
          #  bookstore.css('h3.paddingChoice').select{|s| s.text.include?("CHOOSE")}.any?
          #  course.books.destroy_all
          #  course.books << options_book
          #end
        else
          bookstore.css('.paddingLeft5em').each do |book|
            # don't record any book in CafeScribe format
            unless book.css('li')[1].text.include?("FORMAT")
              # get rid of TITLE: text and extraneous whitespace
              book_title = book.css('li')[0].text.gsub('TITLE:','').gsub(/[\n\t]/,'').strip
              # if there are options and the first character is a digit, remove the first character
              if bookstore.css('h3.paddingChoice').select{|s| s.text.include?("CHOOSE")}.any? and (!!Float(book_title[0]) rescue false)
                book_title = book_title.slice(1..-1).strip
              end
              book_author = book.css('li')[1].text.gsub('AUTHOR:','').strip
              book_edition = book.css('li')[2].text.gsub('EDITION:','').strip
              book_isbn = book.css('li')[5].text.gsub('ISBN:','').strip
              book_new_price = book.css('li')[6].text.gsub('NEW:','').strip
              book_used_price = book.css('li')[7].text.gsub('USED:','').strip
              book = Book.where('title = ? AND author = ?', book_title,book_author).limit(1).all.first
              puts 'TITLE: ' + book_title
              puts 'AUTHOR: ' + book_author
              puts 'EDITION: ' + book_edition
              puts 'ISBN: ' + book_isbn
              puts 'PRICE-NEW: ' + book_new_price
              puts 'PRICE-USED: ' + book_used_price
              if book
                puts "#{book_title} is already in the database!"
                unless course.books.all.include?(book)
                  course.books << book
                end
              else
                puts "Creating a new database entry for #{book_title}!"
                course.books.create!(:title => book_title, :author => book_author, :edition => book_edition, :isbn => book_isbn, :huntley_new => book_new_price, :huntley_used => book_used_price)
              end
              puts "Adding #{book_title} to required list for #{course.name}!"
            end
          end
        end
        if course.books.empty?
          course.books << no_course_book
        end
      #rescue
      #  puts "SKIPPING #{course.name}"
      #  next
      #end                                            
    end
  end 
end