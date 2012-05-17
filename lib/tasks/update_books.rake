# encoding: utf-8
require 'nokogiri'
require 'open-uri'

namespace :db do
  desc "Fill course database with data"
  task :update_books => :environment do
    our_pomona_base_url = 'http://aspc.pomona.edu/courses/search/?end_range=&course_number_min=&spots_left=on&c_pz=on&requirement_area=&c_cm=on&c_po=on&credit=A&c_cu=on&department=&c_sc=on&only_at_least=A&c_hm=on&keywords=&start_range=&instructor=&c_cgu=on&course_number_max=&page='  
    no_course_book = Book.where('title =?', 'Could not find the specified course.')
    no_materials_book = Book.where('title =?', 'No books needed for this class.')
    not_finalized_book = Book.where('title =?', 'Materials Not Finalized For This Class.')
    current_page_num = 1
    course_semester = "FA2012"
    Course.all.each do |course|
      puts 'School: ' + course.school_symbol
      puts 'Department: ' + course.department
      puts 'Number: ' + course.number
      puts 'Name: ' + course.name
      puts 'Prof: ' + course.prof
      puts 'Section: ' + course.section
      #begin
        get_books_for_course(course,no_course_book, no_materials_book, not_finalized_book)
      #rescue
      #  puts "SKIPPING #{course.name}"
      #  next
      #end                                            
    end
  end 
end

def get_books_for_course(course,no_course_book,no_materials_book,not_finalized_book)
  huntley_base_url = "http://www.bkstr.com/webapp/wcs/stores/servlet/booklookServlet?bookstore_id-1=994&term_id-1=FA2012"
  puts huntley_base_url+'&div-1='+course.school_symbol+'&dept-1='+course.department+'&course-1='+course.number+'&section-1='+course.section+'#content'
  bookstore = Nokogiri::HTML(open(huntley_base_url+'&div-1='+course.school_symbol+'&dept-1='+course.department+'&course-1='+course.number+'&section-1='+course.section+'#content'))
  if bookstore.css('.results h2.error')[0] and bookstore.css('.results h2.error')[0].text.include?("Unable to find")
    puts 'No course numbered: ' + course.number
    if course.books.empty?
      course.books << no_course_book
    end
  elsif bookstore.css('.results h2.error')[0] and bookstore.css('.results h2.error')[0].text.include?("No Course Materials Required For This Course")
    puts "No Course Materials Required For This Course: " + course.number
    if course.books.empty?
      course.books << no_materials_book
    end
  elsif bookstore.css('.results h3.paddingChoice')[0] and bookstore.css('.results h3.paddingChoice')[0].text.include?("CHOOSE")
     puts "This course has options for required books: " + course.number
     if course.books.empty?
       course.books << not_finalized_book
     end
  elsif bookstore.css('.results h2.error')[0] and bookstore.css('.results h2.error')[0].text.include?("To Be Determined")
    puts "Materials Not Finalized For This Course: " + course.number
    if course.books.empty?
      course.books << not_finalized_book
    end
  else
    bookstore.css('.paddingLeft5em').each do |book|
      unless book.parent.css('h2').text == 'RECOMMENDED'
        book_title = book.css('li')[0].text.gsub('TITLE:','').strip
        puts 'BOOK TITLE: ' + book_title
        unless book.css('li')[1].text.include?('FORMAT')
          book_author = book.css('li')[1].text.gsub('AUTHOR:','').strip
          puts 'BOOK AUTHOR: ' + book_author 
          if book.css('li')[2].text.gsub('EDITION:','').strip
            book_edition = book.css('li')[2].text.gsub('EDITION:','').strip
            puts 'BOOK EDITION: ' + book_edition
          else
            book_edition = ''
          end
          if book.css('li')[5].text.gsub('ISBN:','').strip
            book_isbn = book.css('li')[5].text.gsub('ISBN:','').strip
            puts 'BOOK ISBN: ' + book_isbn
          else 
            book_isbn = ''
          end
          book = Book.where('title = ? AND author = ?', book_title,book_author).limit(1).all.first
          if book
            puts "#{book.title} is already in the database!"
            unless course.books.all.include?(book)
              puts "Adding #{book.title} to required list for #{course.name}!"
              course.books << book
            end
          else
            puts "Creating a new database entry for #{book_title}!"
            puts "Adding #{book_title} to required list for #{course.name}!"
            course.books.create!(:title => book_title, :author => book_author, :edition => book_edition, :isbn => book_isbn)
          end
        end
      end
    end
  end
  if course.books.empty?
    course.books << no_course_book
  end
end