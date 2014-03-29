class Relationship < ActiveRecord::Base
  validates :person_id, :presence => true

  def spouse
    if spouse_id.nil?
      nil
    else
      Person.find(spouse_id)
    end
  end

  def children
    if child_id.nil?
      nil
    else
      results = []
      results << Person.where(child_id)
      results
    end
  end

  def father
    if father_id.nil?
      nil
    else
      Person.find(father_id)
    end
  end

  def mother
    if mother_id.nil?
      nil
    else
      Person.find(mother_id)
    end
  end
end

