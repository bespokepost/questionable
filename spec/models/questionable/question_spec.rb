require 'spec_helper'

module Questionable
  describe Question do
    let(:question) { create(:question, input_type: Questionable::Question::InputTypes::STRING) }

    describe '.with_subject' do
      subject { Question.with_subject(assignment_subject) }

      [:subject, :user].each do |factory|
        context "with #{factory}" do
          let(:assignment_subject) { create(factory) }
          let!(:assignment) { create(:assignment, question: question, subject: assignment_subject) }
          it { is_expected.to eq [question] }
        end
      end
    end

    describe '#string?' do
      it 'returns true if input_type is string' do
        expect(question).to be_string
      end

      it 'returns false if input_type is not string' do
        question.input_type = Questionable::Question::InputTypes::DATE
        expect(question).not_to be_string
      end
    end

    (Questionable::Question::InputTypes::ALL - [Questionable::Question::InputTypes::STRING]).each do |kind|
      describe "##{kind}?" do
        it "returns true if input_type is #{kind}" do
          question.input_type = kind
          expect(question.send("#{kind}?")).to be_truthy
        end

        it "returns false if input_type is not #{kind}" do
          question.input_type = Questionable::Question::InputTypes::STRING
          expect(question.send("#{kind}?")).to_not be_truthy
        end
      end
    end
  end
end
