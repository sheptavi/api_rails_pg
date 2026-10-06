class CreateApplies < ActiveRecord::Migration[8.1]
  def change
    create_table :applies do |t|
      t.references :job, null: false, foreign_key: true
      t.references :geek, null: false, foreign_key: true
      t.boolean :read, default: false
      t.boolean :invited, default: false
      t.timestamps
    end
  end
end