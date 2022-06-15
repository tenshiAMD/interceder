class CreateIntegrations < ActiveRecord::Migration[6.0]
  def change
    create_table :integrations do |t|
      t.string  :public_uid
      t.string  :name, default: "", null: false
      t.string  :site, default: "", null: false
      t.text    :description, default: "", null: false

      t.timestamps
    end

    add_index :integrations, :public_uid, unique: true
    add_index :integrations, :name, unique: true
  end
end
