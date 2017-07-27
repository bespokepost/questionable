module Questionable
  class Option < ApplicationRecord
    belongs_to :question

    default_scope { order('questionable_options.position ASC') }

    validates_presence_of :title, :question_id
  end
end
