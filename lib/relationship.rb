class Relationship < ActiveRecord::Base
  validates :person_id, :presence => true

  def spouse
    if spouse_id.nil?
      nil
    else
      Person.find(spouse_id)
    end
  end


end
