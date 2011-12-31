require 'nokogiri'
require 'open-uri'

http://www.bkstr.com/webapp/wcs/stores/servlet/booklookServlet?bookstore_id-1=994&term_id-1=SP2012&div-1=SC&dept-1=CLAS&course-1=012&section-1=01#content

colleges = ['PO','HMC', 'CMC', 'SC', 'PZ']
departments = ['AFRI','AISS','AMST','ANTH','ARBC','ARHI','ART','AS','ASAM','ASIA','ASTR','BIOL','CHEM','CHIN','CHLT','CHNT','CHST','CL','CLAS','CLIT','CORE','CREA','CSCI','CSMT','DANC','EA','ECON','EDUC','ENGL','ENGR','EURO','FHS','FINA','FLAN','FREN','FWS','GEOL','GERM','GFS','GOVT','GRMT','GRST','GWS','HHSS','HIST','HMSC','HSID','HUM','ID','IE','IIS','IR','ITAL','JAPN','JPNT','JWST','KORE','LAST','LEAD','LGCS','LGST','LIT','MATH','MCSI','MENA','MES','MFIN','MLLC','MOBI','MS','MSL','MUS','NEUR','NSCI','ONT','ORST','PE','PHIL','PHYS','POLI','POST','PPA','PPE','PSYC','RLIT','RLST','RUSS','RUST','SOC','SOSC','SPAN','SPCH','SPNT','STS','THEA','WGFS','WRIT']
courses = ('000'..'050').to_a
base_url = 'http://www.bkstr.com/webapp/wcs/stores/servlet/booklookServlet?bookstore_id-1=994&term_id-1=SP2012'

colleges.each do |college|
  departments.each do |department|
    courses.each do |course|
      page = Nokogiri::HTML(open(base_url+'&div-1='+college+'&dept-1='+department+'&course-1='+course+'&section-1=01#content'))




&dept-1=CSCI&course-1=081&section-1=01#content

# courses model
# id, name, number, section, school


