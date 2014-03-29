require 'bundler/setup'
require 'pry'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def menu
  puts 'Welcome to the family tree!'
  puts 'What would you like to do?'

  loop do
    puts 'Press a to add a family member.'
    puts '      l to list out the family members.'
    puts '      m to add who someone is married to.'
    puts '      s to see who someone is married to.'
    puts '      j to join a child to his/her parents.'
    puts '      c to see all children for a person.'
    puts 'Press e to exit.'
    choice = gets.chomp

    case choice
    when 'a'
      add_person
    when 'l'
      list
    when 'm'
      add_marriage
    when 's'
      show_marriage
    when 'j'
      add_child
    when 'c'
      show_children
    when 'e'
      exit
    end
  end
end

def add_person
  puts 'What is the name of the family member?'
  name = gets.chomp
  new_person = Person.create(:name => name)
  puts name + " was added to the family tree.\n\n"
end

def add_marriage
  list
  puts 'What is the number of the first spouse?'
  spouse1 = Person.find(gets.chomp)
  puts 'What is the number of the second spouse?'
  spouse2 = Person.find(gets.chomp)

  Relationship.create(:person_id => spouse1.id, :spouse_id => spouse2.id)
  Relationship.create(:person_id => spouse2.id, :spouse_id => spouse1.id)
  puts spouse1.name + " is now married to " + spouse2.name + "."
end

def add_child
  list
  puts 'What is the number of the first parent?'
  parent1 = Person.find(gets.chomp)
  puts 'What is the number of the second parent?'
  parent2 = Person.find(gets.chomp)
  puts 'What is the number of the child?'
  child = Person.find(gets.chomp)
  Relationship.update(:person_id => parent1.id, :child_id => child.id)
  Relationship.update(:person_id => parent2.id, :child_id => child.id)
  puts child.name + " is now saved as a child of " + parent1.name + " and " + parent2.name + "."
end

def list
  puts 'Here are all your relatives:'
  people = Person.all
  people.each do |person|
    puts person.id.to_s + " " + person.name
  end
  puts "\n"
end

def show_marriage
  list
  puts "Enter the number of the relative and I'll show you who they're married to."
  person = Person.find(gets.chomp)
  relationship = Relationship.where("person_id = ?", person.id)
  spouse = Person.find(relationship.first.spouse_id)
  puts person.name + " is married to " + spouse.name + "."
end

def show_children
  list
  all_children = []
  puts "Enter the number of the relative and I'll show you their children."
  person = Person.find(gets.chomp)
  relationship = Relationship.where("person_id = ?", person.id)
  child_obj = Person.where("id = ?", relationship.first.child_id)
  child_obj.each { |child| all_children << child }
  binding.pry
  all_children.each { |child| puts child.name }
end

menu
