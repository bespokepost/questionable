require 'spec_helper'

describe 'answers rake task' do
  include_context 'rake'

  describe 'questionable:update_answers_question_id' do
    before { create_list(:answer, 5, :with_assignment) }

    it 'fills in question_id' do
      subject.invoke
      Questionable::Answer.all.each { |answer| expect(answer.question_id).not_to be_nil }
    end
  end
end
