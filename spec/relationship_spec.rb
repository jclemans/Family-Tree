require 'spec_helper'
require 'pry'

describe Relationship do
  it {should validate_presence_of :person_id}


 context '#spouse' do
    it 'returns the person with their spouse_id' do
      earl = Person.create(:name => 'Earl')
      steve = Person.create(:name => 'Steve')
      relationship = Relationship.create(:person_id => earl.id, :spouse_id => steve.id)
      relationship.spouse.id.should eq steve.id
    end

    it "is nil if they aren't married" do
      earl = Person.create(:name => 'Earl')
      relationship = Relationship.create(:person_id => earl.id, :spouse_id => nil)
      relationship.spouse.should be_nil
    end
  end

  it "updates the spouse's id when it's spouse_id is changed" do
    earl = Person.create(:name => 'Earl')
    steve = Person.create(:name => 'Steve')
    relationship = Relationship.create(:person_id => earl.id, :spouse_id => steve.id)
    relationship.update(:spouse_id => steve.id)
    relationship.reload
    relationship.spouse.id.should eq steve.id
  end

  context '#children' do
    it 'returns all the children for selected parent' do
      mother = Person.create(:name => 'Jenny')
      child = Person.create(:name => 'Timmy')
      relationship = Relationship.create(:person_id => mother.id, :child_id => child.id)
      relationship.children.id.should eq child.id
    end
  end

  context '#father' do
    it 'returns the father for the selected child' do
      child = Person.create(:name => 'Timmy')
      father = Person.create(:name => 'Benny')
      relationship = Relationship.create(:person_id => child.id, :father_id => father.id)
      relationship.father.id.should eq father.id
    end
  end

  context '#mother' do
    it 'returns the mother for the selected child' do
      child = Person.create(:name => 'Timmy')
      mother = Person.create(:name => 'Jenny')
      relationship = Relationship.create(:person_id => child.id, :mother_id => mother.id)
      relationship.mother.id.should eq mother.id
    end
  end
end
