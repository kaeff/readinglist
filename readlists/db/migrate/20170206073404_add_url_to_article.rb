class AddUrlToArticle < ActiveRecord::Migration[5.0]
  def change
    change_table :articles do |t|
      t.string :url
    end
  end
end
