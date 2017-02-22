require 'spec_helper'

module Questionable
  describe Answer do
    let(:answer) { create(:answer) }

    describe '#date_answer' do
      subject { answer.date_answer }

      context 'when the message is a valid date' do
        let(:answer) { create(:answer, message: '2012-10-11') }
        it { should be_a Date }
      end

      context 'when the message is an invalid date' do
        let(:answer) { create(:answer, message: '2012-40-11') }
        it { should be_nil }
      end

      context 'when the message is null' do
        let(:answer) { create(:answer, message: nil) }
        it { should be_nil }
      end
    end
  end
end
