# encoding: utf-8
require 'nokogiri'
require 'open-uri'

namespace :db do
  desc "Fill course database with data"
  task :populate_courses => :environment do
    our_pomona_base_url = 'http://aspc.pomona.edu/courses/search/?end_range=&course_number_min=&spots_left=on&c_pz=on&requirement_area=&c_cm=on&c_po=on&credit=A&c_cu=on&department=&c_sc=on&only_at_least=A&c_hm=on&keywords=&start_range=&instructor=&c_cgu=on&course_number_max=&page='  
    no_course_book = Book.where('title =?', 'Could not find the specified course.')
    no_materials_book = Book.where('title =?', 'No books needed for this class.')
    not_finalized_book = Book.where('title =?', 'Materials Not Finalized For This Class.')
    current_page_num = 1
    course_semester = "FA2012"
    while current_page_num < 75
      #begin
        puts "-----------------------Page: #{current_page_num} -----------------------------"
        current_page_data = Nokogiri::HTML(open(our_pomona_base_url+current_page_num.to_s(10)))
        current_page_data.css('ol.course_list li.odd, li.even').each do |li|
          course = li.css('h3').text
          puts course
          reverse_prof = li.css('h4').text.split(' — ')[0].strip
          unless reverse_prof == 'Staff'
            if reverse_prof.include?(';')
              profs = reverse_prof.gsub('Jr.','').split(';')
              prof =  profs[0].split(',').reverse.join(' ').gsub(',','').strip + ' and ' + profs[1].split(',').reverse.join(' ').gsub(',','').gsub('  ', ' ').strip
            else
              prof = reverse_prof.gsub('Jr.','').split(',').reverse.join(' ').gsub(',','').strip
            end
          else
            prof = reverse_prof
          end
          puts "*************** #{course} ****************"
          course_school = course.split('-')[0][-2,2].strip
          course_department = course.split(/\d/)[0].strip
          course_section = course.split('-')[1][0..1].strip
          course_name = course.split(' — ')[1].strip
          course_number = course.gsub(course_department,'').gsub(course_name,'').gsub(course_school + '-' + course_section,'').gsub('-','').gsub('—','').gsub(' ','')
          puts 'School: ' + course_school
          puts 'Department: ' + course_department
          puts 'Number: ' + course_number
          puts 'Name: ' + course_name
          puts 'Prof: ' + prof
          puts 'Section: ' + course_section
          c =Course.where('department = ? AND number = ? AND prof = ? AND section = ? AND semester = ? AND school_symbol = ?', course_department,course_number,prof,course_section, course_semester, course_school).limit(1).first
          if c
            puts "#{course_name} is already in the database!"
          else
            c = Course.new(:school_symbol => course_school, :department => course_department, :number => course_number, :name => course_name, :section => course_section, :prof => prof, :semester => "FA2012" ) 
            puts "#{course_name} is a new course!"
          end
          if c.save
            get_books_for_course(c,no_course_book, no_materials_book, not_finalized_book)
          end
        end
        current_page_num += 1   
      #rescue
      #  puts "SKIPPING"
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
            book = course.books.create!(:title => book_title, :author => book_author, :edition => book_edition, :isbn => book_isbn)
          end
          if course.books.all.size > 1
            course.books.each do |book|
              if book == no_materials_book or book == not_finalized_book or book == no_course_book
                course.delete(book)
              end
            end
          end 
        end
      end
    end
  end
  if course.books.empty?
    course.books << no_course_book
  end
end


