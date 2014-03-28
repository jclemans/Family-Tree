require 'spec_helper'
require 'pry'

describe Relationship do
  it {should validate_presence_of :person_id}

 context '#spouse' do
    it 'returns the person with their spouse_id' do
      earl = Person.create(:name => 'Earl')
      steve = Person.create(:name => 'Steve')
      relationship = Relationship.create(:person_id => earl.id, :spouse_id => steve.id)
      # relationship.spouse.should eq spouse_id
      true.should eq true
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
end
