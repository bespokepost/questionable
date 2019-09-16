require 'spec_helper'

module Questionable
  describe Assignment do
    describe '.with_subject' do
      subject { Assignment.with_subject(assignment_subject) }

      [:subject, :user].each do |factory|
        context "with #{factory}" do
          let(:assignment_subject) { create(factory) }
          let!(:assignment) { create(:assignment, subject: assignment_subject) }
          it { is_expected.to eq [assignment] }
        end
      end
    end
  end
end
