module Questionable
  class Option < ApplicationRecord
    belongs_to :question

    default_scope { order('questionable_options.position ASC') }

    validates :title, :question_id, presence: true
  end
end
