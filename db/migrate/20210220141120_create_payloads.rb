class CreatePayloads < ActiveRecord::Migration[6.0]
  def change
    create_table :payloads do |t|
      t.string      :public_uid
      t.references  :app, null: false
      t.text        :body, default: "", null: false
      t.text        :response

      t.timestamps
    end

    add_index :payloads, :public_uid, unique: true
  end
end
