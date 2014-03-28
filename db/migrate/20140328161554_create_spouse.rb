class CreateSpouse < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.column :person_id, :integer
      t.column :spouse_id, :integer
      t.timestamps
    end
  end
end
