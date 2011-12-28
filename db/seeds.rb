# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

r = Random.new


def random_isbn(gen)
  gen.rand(0000000000000..9999999999999)
end

def random_dollars(gen)
  gen.rand(1..100)
end

def random_cents(gen)
  gen.rand(10..99)
end

def random_condition
   ['New','Lightly Used', 'Heavily Used', 'Falling Apart'].shuffle.first
end

def random_description
  Faker::Lorem.sentence
end


dom = User.create!(:name => 'Dominick Reinhold', :email => 'dfr12009@pomona.edu', :password => 'foobar', :password_confirmation => 'foobar')
cecil = User.create!(:name => 'Cecil Sagehen', :email => 'csh01887@pomona.edu', :password => 'foobar', :password_confirmation => 'foobar')

dom.listings.create!(:title => "The Hitchhiker's Guide to the Galaxy", :author => "Douglas Adams", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "1984", :author => "George Orwell", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Dune", :author => "Frank Herbert", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Slaughterhouse 5", :author => "Kurt Vonnegut", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Ender's Game", :author => "Orson Scott Card", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Brave New World", :author => "Aldous Huxley", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "The Catcher in the Rye", :author => "J. D. Salinger", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "The Bible", :author => "Various", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Snow Crash", :author => "Neal Stephenson", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Stranger in a Strange Land", :author => "Robert A.  Heinlein", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Surely You're Joking, Mr.  Feynman!", :author => "Richard P. Feynman", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "To Kill A Mockingbird", :author => "Harper Lee", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Neuromancer", :author => "William Gibson", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Something Under the Bed is Drooling", :author => "Bill Waterson", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "There's Treasure Everywhere", :author => "Bill Waterson", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Guns, Germs, and Steel", :author => "Jared Diamond", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Catch-22", :author => "Joseph Heller", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Zen and the Art of Motorcycle Maintenance", :author => "Robert M. Pirsig", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Siddhartha", :author => "Hermann Hesse", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "The Selfish Gene", :author => "Richard Dawkins", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Godel, Escher, Bach,  An eternal golden braid", :author => "Douglas Hofstadter", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Tao Te Ching", :author => "Lao Tse", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "House of Leaves", :author => "Mark Z.  Danielwelski", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "The Giver", :author => "Lois Lowry", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "Crime and Punishment", :author => "Fyodor Dostoyevsky", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
dom.listings.create!(:title => "A People's History of the United States", :author => "Howard Zinn", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "The Fellowship of the Ring", :author => "J. R. R. Tolkien", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "Ishmael", :author => "Daniel Quinn", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "A Brief History of Time", :author => "Stephen Hawking", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "Lolita", :author => "Vladimir Nabokov", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "The Count of Monte Cristo", :author => "Alexandre Dumas", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "The Golden Compass", :author => "Philip Pullman", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "The Stranger", :author => "Albert Camus", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "The Butter Battle Book", :author => "Dr. Seuss", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "The 500 Hats of Bartholomew Cubbins", :author => "Dr. Seuss", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "The Road", :author => "Cormac McCarthy", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "Lord of the Flies", :author => "William Golding", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "The Monster At The End Of This Book", :author => "Jon Stone and Michael Smollin", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "Fear and Loathing in Las Vegas", :author => "Hunter S. Thompson", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "A Short History of Nearly Everything", :author => "Bill Bryson", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "Do Androids Dream of Electric Sheep?", :author => "Phillip K. Dick", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "A Hundred Years of Solitude", :author => "Gabriel Garcia Marquez", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "The Art of War", :author => "Sun Tzu", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "How to Win Friends and Influence People", :author => "Dale Carnegie", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "The Hyperion Cantos", :author => "Dan Simmons", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "A Confederacy of Dunces", :author => "John Kennedy Toole", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "Common Sense, the Rights of Man and Other Essential Writings of Thomas Paine", :author => "Thomas Paine", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "Declaration of Independence", :author => "Thomas Jefferson", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "Cat's Cradle", :author => "Kurt Vonnegut", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "Fahrenheit 451", :author => "Ray Bradbury", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "Odyssey", :author => "Homer", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )
cecil.listings.create!(:title => "None", :author => "None", :isbn => random_isbn(r), :price_dollars => random_dollars(r), :price_cents => random_cents(r), :condition => random_condition, :description => random_description )

