require 'nokogiri'
require 'open-uri'

namespace :db do
  desc "Fill course database with data"
  task :populate_courses => :environment do
    #colleges = ['PO','HM', 'CM', 'SC', 'PZ']
    colleges = ['PO']
    departments = ['AFRI','AISS','AMST','ANTH','ARBC','ARHI','ART','AS','ASAM','ASIA','ASTR','BIOL','CHEM','CHIN','CHLT','CHNT','CHST','CL','CLAS','CLIT','CORE','CREA','CSCI','CSMT','DANC','EA','ECON','EDUC','ENGL','ENGR','EURO','FHS','FINA','FLAN','FREN','FWS','GEOL','GERM','GFS','GOVT','GRMT','GRST','GWS','HHSS','HIST','HMSC','HSID','HUM','ID','IE','IIS','IR','ITAL','JAPN','JPNT','JWST','KORE','LAST','LEAD','LGCS','LGST','LIT','MATH','MCSI','MENA','MES','MFIN','MLLC','MOBI','MS','MSL','MUS','NEUR','NSCI','ONT','ORST','PE','PHIL','PHYS','POLI','POST','PPA','PPE','PSYC','RLIT','RLST','RUSS','RUST','SOC','SOSC','SPAN','SPCH','SPNT','STS','THEA','WGFS','WRIT']
    #departments = ['MATH']
    courses = ('000'..'200').to_a
    #courses = ['171']
    huntley_base_url = 'http://www.bkstr.com/webapp/wcs/stores/servlet/booklookServlet?bookstore_id-1=994&term_id-1=SP2012'
    colleges.each do |college|
      departments.each do |department| 
        courses.each do |course|
          our_pomona_base_url = 'http://aspc.pomona.edu/courses/search/?department='
          department_map = Hash[[[3,'AFRI'],[1,'AISS'],[4,'AMST'],[5,'ANTH'],[6,'ARBC'],[9,'ARHI'],[7,'ART'],[2,'AS'],[11,'ASAM'],[12,'ASIA'],[13,'ASTR'],[14,'BIOL'],[17,'CHEM'],[20,'CHIN'],[18,'CHLT'],[21,'CHNT'],[19,'CHST'],[22,'CL'],[23,'CLAS'],[29,'CLIT'],[27,'CORE'],[28,'CREA'],[26,'CSCI'],[25,'CSMT'],[31,'DANC'],[36,'EA'],[32,'ECON'],[33,'EDUC'],[35,'ENGL'],[34,'ENGR'],[37,'EURO'],[42,'FHS'],[38,'FINA'],[40,'FLAN'],[41,'FREN'],[43,'FWS'],[46,'GEOL'],[47,'GERM'],[45,'GFS'],[50,'GOVT'],[48,'GRMT'],[49,'GRST'],[44,'GWS'],[116,'HHSS'],[52,'HIST'],[56,'HMSC'],[53,'HSID'],[55,'HUM'],[60,'ID'],[58,'IE'],[62,'IIS'],[61,'IR'],[63,'ITAL'],[64,'JAPN'],[65,'JPNT'],[66,'JWST'],[67,'KORE'],[69,'LAST'],[70,'LEAD'],[73,'LGCS'],[71,'LGST'],[74,'LIT'],[77,'MATH'],[84,'MCSI'],[80,'MENA'],[79,'MES'],[76,'MFIN'],[82,'MLLC'],[83,'MOBI'],[78,'MS'],[81,'MSL'],[85,'MUS'],[87,'NEUR'],[86,'NSCI'],[88,'ONT'],[89,'ORST'],[92,'PE'],[90,'PHIL'],[93,'PHYS'],[95,'POLI'],[94,'POST'],[100,'PPA'],[91,'PPE'],[99,'PSYC'],[102,'RLIT'],[101,'RLST'],[103,'RUSS'],[104,'RUST'],[108,'SOC'],[107,'SOSC'],[109,'SPAN'],[111,'SPCH'],[110,'SPNT'],[105,'STS'],[112,'THEA'],[114,'WGFS'],[115,'WRIT']]].invert
          classes_exist = Nokogiri::HTML(open(our_pomona_base_url+department_map[department].to_s(10)+'&only_at_least=A&start_range=&end_range=&instructor=&credit=A&min_class_size=&keywords=&page='+p.to_s(10)))
          if classes_exist.css('ol.course_list li.stats')[0].text.include?('found 0 courses')
            next
          end
          begin
            sleep(1.0/12.0)
            puts huntley_base_url+'&div-1='+college+'&dept-1='+department+'&course-1='+course+'&section-1=01#content'
            bookstore = Nokogiri::HTML(open(huntley_base_url+'&div-1='+college+'&dept-1='+department+'&course-1='+course+'&section-1=01#content'))
            if bookstore.css('.results h2.error')[0] and bookstore.css('.results h2.error')[0].text.include?("Unable to find")
              puts 'No course numbered: ' + course
            elsif bookstore.css('.results h2.error')[0] and bookstore.css('.results h2.error')[0].text.include?("No Course Materials Required For This Course")
              puts "No Course Materials Required For This Course: " + course
              book_title = "No Course Materials Required For This Course"
              book_author = "No Course Materials Required For This Course"
              match_course_num_to_title(book_title,book_author,course,department,college)
            else
              book_title = bookstore.css('.paddingLeft5em li')[0].text.split(':')[1].strip
              book_author = bookstore.css('.paddingLeft5em li')[1].text.split(':')[1].strip
              match_course_num_to_title(book_title,book_author,course,department,college)
            end
          rescue
            puts "SKIPPING"
            next
          end
        end
      end
    end     
  end
end
         
         
        
        
def match_course_num_to_title(book_title,book_author,course,department,college) 
  our_pomona_base_url = 'http://aspc.pomona.edu/courses/search/?department='
  department_map = Hash[[[3,'AFRI'],[1,'AISS'],[4,'AMST'],[5,'ANTH'],[6,'ARBC'],[9,'ARHI'],[7,'ART'],[2,'AS'],[11,'ASAM'],[12,'ASIA'],[13,'ASTR'],[14,'BIOL'],[17,'CHEM'],[20,'CHIN'],[18,'CHLT'],[21,'CHNT'],[19,'CHST'],[22,'CL'],[23,'CLAS'],[29,'CLIT'],[27,'CORE'],[28,'CREA'],[26,'CSCI'],[25,'CSMT'],[31,'DANC'],[36,'EA'],[32,'ECON'],[33,'EDUC'],[35,'ENGL'],[34,'ENGR'],[37,'EURO'],[42,'FHS'],[38,'FINA'],[40,'FLAN'],[41,'FREN'],[43,'FWS'],[46,'GEOL'],[47,'GERM'],[45,'GFS'],[50,'GOVT'],[48,'GRMT'],[49,'GRST'],[44,'GWS'],[116,'HHSS'],[52,'HIST'],[56,'HMSC'],[53,'HSID'],[55,'HUM'],[60,'ID'],[58,'IE'],[62,'IIS'],[61,'IR'],[63,'ITAL'],[64,'JAPN'],[65,'JPNT'],[66,'JWST'],[67,'KORE'],[69,'LAST'],[70,'LEAD'],[73,'LGCS'],[71,'LGST'],[74,'LIT'],[77,'MATH'],[84,'MCSI'],[80,'MENA'],[79,'MES'],[76,'MFIN'],[82,'MLLC'],[83,'MOBI'],[78,'MS'],[81,'MSL'],[85,'MUS'],[87,'NEUR'],[86,'NSCI'],[88,'ONT'],[89,'ORST'],[92,'PE'],[90,'PHIL'],[93,'PHYS'],[95,'POLI'],[94,'POST'],[100,'PPA'],[91,'PPE'],[99,'PSYC'],[102,'RLIT'],[101,'RLST'],[103,'RUSS'],[104,'RUST'],[108,'SOC'],[107,'SOSC'],[109,'SPAN'],[111,'SPCH'],[110,'SPNT'],[105,'STS'],[112,'THEA'],[114,'WGFS'],[115,'WRIT']]].invert
  puts book_title
  puts book_author
  p = 1
  course_name = nil
  while p < 10 and course_name.nil?
    puts 'Page: ' + p.to_s(10)
    puts our_pomona_base_url+department_map[department].to_s(10)+'&only_at_least=A&start_range=&end_range=&instructor=&credit=A&min_class_size=&keywords=&page='
    our_pomona = Nokogiri::HTML(open(our_pomona_base_url+department_map[department].to_s(10)+'&only_at_least=A&start_range=&end_range=&instructor=&credit=A&min_class_size=&keywords=&page='+p.to_s(10)))
    our_pomona.css('ol.course_list h3 a').each do |title|
      #puts title.text
      if title.text.include?(course) and title.text.include?(college)
        puts 'ACCEPTED: ' + title.text
        course_name = title.text
      end
    end
    p+=1                                                              
  end
  if course_name
    course = Course.create!(:name => course_name, :number => course, :department => department, :school => college, :book_title => book_title, :book_author => book_author)
  end  
end


#&dept-1=CSCI&course-1=081&section-1=01#content

# courses model
# id, name, number, department, school




#  id          :integer         not null, primary key
#  name        :string(255)
#  number      :string(255)
#  department  :string(255)
#  school      :string(255)
#  book_title  :string(255)
#  book_author :string(255)







