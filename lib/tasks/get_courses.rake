# encoding: utf-8
require 'nokogiri'
require 'open-uri'

namespace :db do
  desc "Checks OurPomona (ASPC) for new courses."
  task :get_courses => :environment do
    num_pages = 78 # this needs to be manually set by visiting the ASPC website
    course_semester = "FA2012" # update each semester
    our_pomona_base_url = 'http://aspc.pomona.edu/courses/search/?end_range=&course_number_min=&spots_left=on&c_pz=on&requirement_area=&c_cm=on&c_po=on&credit=A&c_cu=on&department=&c_sc=on&only_at_least=A&c_hm=on&keywords=&start_range=&instructor=&c_cgu=on&course_number_max=&page='  
    school_names = {"PO" => "Pomona College", "CM" => "Claremont McKenna College", "SC" => "Scripps College", "PZ" => "Pitzer College", "HM" => "Harvey Mudd College", "KS" => "Claremont Colleges", "JP" => "Claremont Colleges", "JM" => "Claremont Colleges", "JT" => "Claremont Colleges", "AF" => "Claremont Colleges", "AA" => "Claremont Colleges", "CG" => "Claremont Colleges", "CH" => "Claremont Colleges" }
    new_courses = 0
    current_page_num = 1
    while current_page_num < num_pages
      #begin
        puts "-----------------------Page: #{current_page_num} -----------------------------"
        current_page_data = Nokogiri::HTML(open(our_pomona_base_url+current_page_num.to_s(10)))
        current_page_data.css('ol.course_list li.odd, li.even').each do |li|
          course = li.css('h3').text
          reverse_prof = li.css('h4').text.split(' — ')[0].strip
          puts "*************** #{course} ****************"
          course_school_symbol = course.split('-')[0][-2,2].strip
          course_department = course.split(/\d/)[0].strip
          course_section = course.split('-')[1][0..1].strip
          course_name = course.split(' — ')[1].strip
          course_number = course.gsub(course_department,'').gsub(course_name,'').gsub(course_school_symbol + '-' + course_section,'').gsub('-','').gsub('—','').gsub(' ','')
          course_prof = get_prof(reverse_prof)
          puts 'School: ' + course_school_symbol
          puts 'Department: ' + course_department
          puts 'Number: ' + course_number
          puts 'Name: ' + course_name
          puts 'Prof: ' + course_prof
          puts 'Section: ' + course_section
          c = Course.where('department = ? AND number = ? AND prof = ? AND section = ? AND semester = ? AND school_symbol = ?', course_department,course_number,course_prof,course_section, course_semester, course_school_symbol).limit(1).first
          if c
            puts "#{course_name} is already in the database!"
          else
            c = Course.new(:school_symbol => course_school_symbol, :school_name => school_names[course_school_symbol], :school_id => 1, :department => course_department, :number => course_number, :name => course_name, :section => course_section, :prof => course_prof, :semester => course_semester ) 
            puts "#{course_name} is a new course!"
            new_courses += 1 if c.save
          end
        end
        current_page_num += 1   
      #rescue
      #  puts "SKIPPING"
      #  next
      #end                                                          
    end
    puts "#{new_courses} new courses added!"
  end 
end

def get_prof(reverse_prof)
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
  return prof
end



