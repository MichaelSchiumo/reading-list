class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.string :topic
      t.string :url
      t.text :notes
    end
  end
end