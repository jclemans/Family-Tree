class EditPeople < ActiveRecord::Migration
  def change
    remove_column :people, :spouse_id
  end
end
