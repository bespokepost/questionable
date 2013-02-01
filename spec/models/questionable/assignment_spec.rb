require 'spec_helper'

module Questionable
  describe Assignment do
    let(:question) { create(:question, input_type: 'string') }
    let(:subject)  { create(:user) }  # our subject will be a user

    before do 
      @assignment_to_subject = Assignment.create(question_id: question.id, subject: subject) 
      @assignment_to_symbol = Assignment.create(question_id: question.id, subject_type: :foobar) 
    end

    describe "#with_subject" do
      it "should fetch the assignment by symbol" do
        Assignment.with_subject(:foobar).should == [@assignment_to_symbol]
      end

      it "should fetch the assignments for a user and a subject" do
        Assignment.with_subject(subject).should == [@assignment_to_subject]
      end
    end
  end
end
