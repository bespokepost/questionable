module Questionable
  class Option < ActiveRecord::Base
    belongs_to :question

    validates_presence_of :title, :question_id
  end
end
