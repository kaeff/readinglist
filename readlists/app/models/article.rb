class Article < ApplicationRecord
  def url=(url)
    @url = url.strip
    super
  end

  def slug
    "#{title.parameterize}-#{id}"
  end
end
