class User < ActiveRecord::Base
  has_and_belongs_to_many :schools
  has_many :networks, :through => :schools, :uniq => true
  has_many :listings, :dependent => :destroy
  has_many :requests
  attr_accessible :name, :email, :uid # PROTECT UID BEFORE PUBLIC LAUNCH!!
  
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
    schools = auth["extra"]["raw_info"]["education"].each.select{|s| s["type"] == 'College'}
    @claremont_colleges_network = Network.find_by_name('Claremont Colleges') || Network.create!(:name => 'Claremont Colleges')
    claremont_colleges = ['Pomona College', 'Claremont McKenna College', 
                          'Harvey Mudd College', 'Scripps College',
                          'Pitzer College', 'Keck Graduate Institute',
                          'Claremont Graduate University']
    schools.each do |s| 
      @school = School.where("uid = ?", s["school"]["id"]).limit(1).first
      if @school.nil? # if no one from this school has signed up before
        @school = School.create(:uid => s["school"]["id"], :name => s["school"]["name"])
        @network = Network.find_by_name(s["school"]["name"]) || Network.create(:name => s["school"]["name"])
        @school.networks << @network
        self.schools << @school
      end
      unless self.schools.all.include?(@school)
        self.schools << @school
      end
      if claremont_colleges.include?(@school.name)
        self.current_network = @claremont_colleges_network
        unless @school.networks.all.include?(@claremont_colleges_network)
          @school.networks << @claremont_colleges_network
        end        
      end
    end
    self.save
    puts "Your name is #{self.name}."
    puts "Your email is #{self.email}."
    if self.schools.empty?
      puts "You don't have any schools in your Facebook profile!"
    else
      self.schools.each{|s| puts "You attend #{s.name}."}
      self.networks.each{|n| puts "You are a part of the #{n.name} network."}
      puts "Your current network is #{self.current_network.id}."
    end
  end

end
# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)
#  name            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  uid             :string(255)
#  current_network :string(255)
#

