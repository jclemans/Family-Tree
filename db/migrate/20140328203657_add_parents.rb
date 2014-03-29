class AddParents < ActiveRecord::Migration
  def change
    add_column :relationships, :mother_id, :integer
    add_column :relationships, :father_id, :integer

  end
end
