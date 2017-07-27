require 'spec_helper'

module Questionable
  describe Question do
    let(:question) { create(:question, input_type: 'string') }
    let(:subject)  { create(:user) }

    before do
      @assignment_to_subject = Assignment.create(question_id: question.id, subject: subject)
      @assignment_to_symbol = Assignment.create(question_id: question.id, subject_type: :foobar)
    end

    describe '#with_subject' do
      it 'should fetch the assignment by symbol' do
        expect(Question.with_subject(:foobar)).to eq [question]
      end

      it 'should fetch the assignments for a user and a subject' do
        expect(Question.with_subject(subject)).to eq [question]
      end
    end

    describe '#string?' do
      it 'returns true if input_type is string' do
        expect(question).to be_string
      end

      it 'returns false if input_type is not string' do
        question.input_type = 'date'
        expect(question).not_to be_string
      end
    end

    %w(checkboxes multiselect radio select date).each do |kind|
      describe "##{kind}?" do
        it "returns true if input_type is #{kind}" do
          question.input_type = kind
          expect(question.send("#{kind}?")).to be_truthy
        end

        it "returns false if input_type is not #{kind}" do
          question.input_type = 'string'
          expect(question.send("#{kind}?")).to_not be_truthy
        end
      end
    end
  end
end
