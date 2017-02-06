class Article < ApplicationRecord
  def url=(url)
    @url = url.strip
    super
  end
end
