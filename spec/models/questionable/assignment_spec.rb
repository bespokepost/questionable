require 'spec_helper'

module Questionable
  describe Assignment do
    describe '.with_subject' do
      subject { Assignment.with_subject(assignment_subject) }

      context 'with a string' do
        let(:assignment_subject) { 'foobar' }
        let!(:assignment) { create(:assignment, subject_type: assignment_subject) }
        it { is_expected.to eq [assignment] }
      end

      context 'with a symbol' do
        let(:assignment_subject) { :foobar }
        let!(:assignment) { create(:assignment, subject_type: assignment_subject) }
        it { is_expected.to eq [assignment] }
      end

      context 'with an object' do
        let(:assignment_subject) { create(:user) }
        let!(:assignment) { create(:assignment, subject: assignment_subject) }
        it { is_expected.to eq [assignment] }
      end
    end
  end
end
