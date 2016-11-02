class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :question, null: false, unique: true ,limit:1000
      t.references :user, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
    # change_column :articles, :body, :text, :limit => 4294967295
  end
end
