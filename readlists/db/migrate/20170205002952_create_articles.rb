class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :byline
      t.string :excerpt
      t.boolean :readerable
      t.datetime :scraped_at
      t.string :content_html

      t.timestamps
    end
  end
end
