require 'spec_helper'

module Questionable
  describe Subject do
    let(:assignment_subject) { create(:subject) }

    describe '#assignments' do
      subject { assignment_subject.assignments }
      let!(:assignment) { create(:assignment, subject: assignment_subject) }
      it { is_expected.to include assignment }
    end

    describe '#questions' do
      subject { assignment_subject.questions }
      let!(:assignment) { create(:assignment, subject: assignment_subject) }
      it { is_expected.to include assignment.question }
    end
  end
end
