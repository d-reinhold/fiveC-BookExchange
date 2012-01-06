# encoding: utf-8
require 'nokogiri'
require 'open-uri'

namespace :db do
  desc "Fill course database with data"
  task :populate_courses => :environment do
    our_pomona_base_url = 'http://aspc.pomona.edu/courses/search/?department=&only_at_least=A&start_range=&end_range=&c_cgu=on&c_cm=on&c_cu=on&c_hm=on&c_po=on&c_pz=on&c_sc=on&instructor=&credit=A&min_class_size=&keywords=&page='  
    current_page_num = 1
    while current_page_num < 73
      begin
        puts "--------------------Page: #{current_page_num} -----------------------------"
        current_page_data = Nokogiri::HTML(open(our_pomona_base_url+current_page_num.to_s(10)))
        current_page_data.css('ol.course_list li.even').each do |li|
          course = li.css('h3').text
          puts course
          prof = li.css('h4').text.split(' — ')[0].strip
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
          c = Course.new(:school => course_school, :department => course_department, :number => course_number, :name => course_name, :section => course_section, :prof => prof ) 
          if c.save
            get_books_for_course(c)
          end
        end
        current_page_num += 1   
      rescue
        puts "SKIPPING"
        next
      end                                                          
    end
  end 
end

def get_books_for_course(course)
  huntley_base_url = 'http://www.bkstr.com/webapp/wcs/stores/servlet/booklookServlet?bookstore_id-1=994&term_id-1=SP2012'
  puts huntley_base_url+'&div-1='+course.school+'&dept-1='+course.department+'&course-1='+course.number+'&section-1='+course.section+'#content'

  bookstore = Nokogiri::HTML(open(huntley_base_url+'&div-1='+course.school+'&dept-1='+course.department+'&course-1='+course.number+'&section-1='+course.section+'#content'))
  if bookstore.css('.results h2.error')[0] and bookstore.css('.results h2.error')[0].text.include?("Unable to find")
    puts 'No course numbered: ' + course.number
    course.books.create!(:title => 'Could not find the specified course.', :author => '', :edition => '', :isbn => '')
  elsif bookstore.css('.results h2.error')[0] and bookstore.css('.results h2.error')[0].text.include?("No Course Materials Required For This Course")
    puts "No Course Materials Required For This Course: " + course.number
    course.books.create!(:title => 'No books needed for this class.', :author => '', :edition => '', :isbn => '')
  elsif bookstore.css('.results h2.error')[0] and bookstore.css('.results h2.error')[0].text.include?("To Be Determined")
    puts "Materials Not Finalized For This Course: " + course.number
    course.books.create!(:title => 'Materials Not Finalized For This Class.', :author => '', :edition => '', :isbn => '')
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
          course.books.create!(:title => book_title, :author => book_author, :edition => book_edition, :isbn => book_isbn)
        end
      end
    end
  end
  if course.books.empty?
    puts 'WTF?'
    course.books.create!(:title => 'WEIRD ERROR', :author => '', :edition => '', :isbn => '')
  end
end


