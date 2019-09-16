module Questionable
  # A subject is used to group assignments into similar concepts
  # e.g. math questions can be grouped by a Mathematics subject.
  class Subject < ApplicationRecord
    has_many :assignments, inverse_of: :subject, as: :subject, dependent: :nullify
    has_many :questions, through: :assignments

    validates :slug, presence: true, uniqueness: true
    validates :title, presence: true
  end
end
