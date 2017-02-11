class ListEntry < ApplicationRecord
  belongs_to :list
  belongs_to :article
end
