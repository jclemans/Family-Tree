require 'spec_helper'

describe Person do
  it { should validate_presence_of :name }
  it {should have_many :relationships }

end
