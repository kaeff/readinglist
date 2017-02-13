class List < ApplicationRecord
  has_many :list_entries
  has_many :articles, through: :list_entries

  def slug
    "#{title.parameterize}-#{id}"
  end
end
