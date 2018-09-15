class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :topic
      t.string :url
      t.text :notes
    end
  end
end