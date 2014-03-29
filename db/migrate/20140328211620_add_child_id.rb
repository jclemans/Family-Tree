class AddChildId < ActiveRecord::Migration
  def change
    add_column :relationships, :child_id, :integer
  end
end
