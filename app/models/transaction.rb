class Transaction < ApplicationRecord
  # enum result: ['success', 'failed']
  belongs_to :invoice

  scope :successful, -> { where(result: 'success') }

  default_scope { order(:id) }
end
