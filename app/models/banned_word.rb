class BannedWord < ApplicationRecord
  validates :word, presence: true, uniqueness: true
  validates :policy, inclusion: { in: %w[ban warn] }
  validates :match_target, inclusion: { in: %w[title_only content_only both] }

  serialize :exceptions, Array
end
