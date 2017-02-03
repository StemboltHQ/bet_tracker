class CreateBetOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :bet_options do |t|
      t.text :option_text
      t.timestamps
    end
  end
end
