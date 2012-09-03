class User < ActiveRecord::Base
  has_and_belongs_to_many :schools, :uniq => true
  has_many :listings, :dependent => :destroy
  has_many :requests
  attr_accessible :name, :email #, :uid # PROTECT UID BEFORE PUBLIC LAUNCH!!
  
  validates :name, :presence => true, 
                   :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :uniqueness => { :case_insensitive => true }        
  validates :uid, :uniqueness => true
  
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
    end
  end
  
  def update_with_omniauth(auth)
    self.name = auth["info"]["name"]
    self.email = auth["info"]["email"]
    education = auth["extra"]["raw_info"]["education"]
    unless education.nil?
      schools = education.each.select{|s| s["type"] == 'College'}
      @claremont_colleges = School.find_by_name('Claremont Colleges')
      claremont_colleges = ['Pomona College', 'Claremont McKenna College', 
                            'Harvey Mudd College', 'Scripps College',
                            'Pitzer College', 'Keck Graduate Institute',
                            'Claremont Graduate University', 'Claremont Colleges']
      unless schools.nil?
        schools.each do |s| 
          @school = School.where("name = ?", s["school"]["name"]).limit(1).first
          if @school.nil? # if no one from this school has signed up before
            @school = School.create(:name => s["school"]["name"])
            self.schools << @school
          end
          unless self.schools.all.include?(@school)
            puts "Adding #{@school.name} to your schools."
            self.schools << @school
          end
          if claremont_colleges.include?(@school.name)
            self.default_school_name = @claremont_colleges.name
            self.default_school_id = @claremont_colleges.id   
            unless self.schools.all.include?(@claremont_colleges)
              self.schools << @claremont_colleges
            end
            puts "Setting #{self.default_school_name} to be your current network."       
          end
        end
      end
    end
    if self.default_school_id.nil?
      # not a member of the claremont colleges
      self.default_school_id = -1
      if self.schools.empty?
        #user has no FB colleges
        self.default_school_name = 'No FB Colleges'
      else
        self.default_school_name = 'Not Claremont Colleges'
      end 
    end
    self.save!
    puts "Your name is #{self.name}."
    puts "Your email is #{self.email}."
    if self.schools.empty?
      puts "You don't have any schools in your Facebook profile!"
    else
      self.schools.each{|s| puts "You attend #{s.name}."}
    end
    self.schools.each{|s| s.save!}

    
    
# Here is some more general code for when Campus Bookswap opens to the public    
=begin
    
    
    
    @claremont_colleges = School.find_by_name('Claremont Colleges') || School.create!(:name => 'Claremont Colleges')
    claremont_colleges = ['Pomona College', 'Claremont McKenna College', 
                          'Harvey Mudd College', 'Scripps College',
                          'Pitzer College', 'Keck Graduate Institute',
                          'Claremont Graduate University']
    schools.each do |s| 
      @school = School.where("name = ?", s["school"]["name"]).limit(1).first
      if @school.nil? # if no one from this school has signed up before
        @school = School.create(:name => s["school"]["name"])
        self.schools << @school
      end
      unless self.schools.all.include?(@school)
        puts "Adding #{@school.name} to your schools."
        self.schools << @school
      end
      if claremont_colleges.include?(@school.name)
        self.default_school_name = @claremont_colleges.name
        self.default_school_id = @claremont_colleges.id     
        puts "Setting #{self.default_school_name} to be your current network."       
      end
    end
    if self.current_school_id.nil? and not self.schools.empty?
      #this should be moved to the session controller later for the select default school page
      self.current_school_id = self.school.first.id
      self.current_school_name = self.schools.first.name
    end
    self.save!
    puts "Your name is #{self.name}."
    puts "Your email is #{self.email}."
    if self.schools.empty?
      puts "You don't have any schools in your Facebook profile!"
    else
      self.schools.each{|s| puts "You attend #{s.name}."}
    end
    self.schools.each{|s| s.save!}
=end    

  end

end
# == Schema Information
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  email               :string(255)
#  name                :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  uid                 :string(255)
#  default_school_name :string(255)
#  default_school_id   :integer
#

