require 'spec_helper'

module Questionable
  describe Assignment do
    let(:question) { create(:question, input_type: 'string') }
    let(:subject)  { create(:user) }

    before do
      @assignment_to_subject = Assignment.create(question_id: question.id, subject: subject)
      @assignment_to_symbol = Assignment.create(question_id: question.id, subject_type: :foobar)
    end

    describe '#with_subject' do
      it 'should fetch the assignment by symbol' do
        expect(Assignment.with_subject(:foobar)).to eq [@assignment_to_symbol]
      end

      it 'should fetch the assignments for a user and a subject' do
        expect(Assignment.with_subject(subject)).to eq [@assignment_to_subject]
      end
    end
  end
end
