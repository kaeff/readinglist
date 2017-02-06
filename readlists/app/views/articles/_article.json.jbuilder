json.extract! article, :id, :title, :byline, :excerpt, :readerable, :scraped_at, :content_html, :created_at, :updated_at
json.url article_url(article, format: :json)