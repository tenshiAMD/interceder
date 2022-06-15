class CreateApps < ActiveRecord::Migration[6.0]
  def change
    create_table :apps do |t|
      t.string  :public_uid
      t.string  :name, default: "", null: false
      t.text    :link, default: "", null: false

      t.timestamps
    end

    add_index :apps, :public_uid, unique: true
    add_index :apps, %i[name link], unique: true
  end
end
