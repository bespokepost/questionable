require 'spec_helper'

module Questionable
  describe AnswersController do
    let(:question1)     { create(:question, input_type: 'radio', title: "What's your favorite color?") }
    let(:question2)     { create(:question, input_type: 'select', title: "How tall are you?") }
    let(:q1_option1)    { create(:option, question: question1, title: 'Blue') }
    let(:q1_option2)    { create(:option, question: question1, title: 'Red')  }
    let(:q2_option1)    { create(:option, question: question2, title: 'Blue') }
    let(:q2_option2)    { create(:option, question: question2, title: 'Red')  }
    let(:assignment1)   { create(:assignment, question: question1, subject_type: 'preferences') }
    let(:assignment2)   { create(:assignment, question: question2, subject_type: 'preferences') }
    let(:user)          { create(:user) }

    before do
      sign_in(user)
      request.env['HTTP_REFERER'] = '/'
    end

    describe "POST #create" do
      it "should create an answer for the current user" do
        Answer.count.should == 0
        post :create, assignment_id: assignment1.id, answer: { option_id: q1_option1.id, message: nil }, use_route: :answers
        a = Answer.first
        a.assignment_id.should == assignment1.id
        a.option_id.should == q1_option1.id
      end

      it "should create an answer with an XHR" do
        Answer.count.should == 0
        xhr :post, :create, assignment_id: assignment1.id, answer: { option_id: q1_option1.id, message: nil }, use_route: :answers
        a = Answer.first
        a.assignment_id.should == assignment1.id
        a.option_id.should == q1_option1.id
      end
    end

    describe "POST #create_multiple" do
      it "should create answers for each question answered" do
        post :create_multiple, answers: { assignment1.id => [ q1_option1.id ], assignment2.id => [ q2_option2.id ]  }, use_route: :answers
        assignment1.answered_options.should == [q1_option1]
        assignment2.answered_options.should == [q2_option2]
      end

      it "should create multiple answers to a multi-answer question" do
        post :create_multiple, answers: { assignment1.id => [ q1_option1.id, q1_option2.id ] }, use_route: :answers
        assignment1.answered_options.should == [q1_option1, q1_option2]
      end
      
      it "should remove old answers for answered questions" do
        assignment1.answers << create(:answer, user_id: user.id, option_id: q1_option1.id)

        post :create_multiple, answers: { assignment1.id => [ q1_option2.id ] }, use_route: :answers
        assignment1.answered_options.should == [q1_option2]
      end

      it "should not create an answer with a blank select" do
        Answer.count.should == 0

        expect {
          post :create_multiple, answers: { assignment1.id => [ '' ] }, use_route: :answers
        }.not_to change { Answer.count }
      end
    end
  
  end
end
