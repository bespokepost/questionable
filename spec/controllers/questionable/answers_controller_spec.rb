require 'spec_helper'

module Questionable
  describe AnswersController do
    let(:question1)     { create(:question, input_type: 'radio', title: "What's your favorite color?") }
    let(:question2)     { create(:question, input_type: 'select', title: 'How tall are you?') }
    let(:q1_option1)    { create(:option, question: question1, title: 'Blue') }
    let(:q1_option2)    { create(:option, question: question1, title: 'Red')  }
    let(:q2_option1)    { create(:option, question: question2, title: 'Blue') }
    let(:q2_option2)    { create(:option, question: question2, title: 'Red')  }
    let(:assignment1)   { create(:assignment, question: question1, subject_type: 'preferences') }
    let(:assignment2)   { create(:assignment, question: question2, subject_type: 'preferences') }
    let(:user)          { create(:user) }
    let(:subject_assignment) { create(:assignment, question: question1, subject: user) }

    let(:date_question) { create(:question, input_type: 'date', title: 'What is your birthday?') }
    let(:date_assignment) { create(:assignment, question: date_question, subject_type: 'preferences') }

    before do
      sign_in(user)
      request.env['HTTP_REFERER'] = '/foo'
    end

    describe 'POST #create' do
      it 'should create answers for each question answered' do
        post :create, params: { answers: { assignment1.id => [ q1_option1.id ], assignment2.id => [ q2_option2.id ]  }, use_route: :answers }
        assignment1.answered_options.should == [q1_option1]
        assignment2.answered_options.should == [q2_option2]
      end

      context 'when no referrer is set' do
        before { request.env['HTTP_REFERER'] = nil }
        it 'should redirect to root' do
          post :create, params: { answers: { subject_assignment.id => [q1_option2.id] }, use_route: :answers }
          response.should redirect_to '/'
        end
      end

      context 'when the assignment is to a subject' do
        it 'should create an assignment' do
          post :create, params: { answers: { subject_assignment.id => [q1_option2.id] }, use_route: :answers }
          subject_assignment.answered_options.should == [q1_option2]
        end
      end

      it 'should create multiple answers to a multi-answer question' do
        post :create, params: { answers: { assignment1.id => [ q1_option1.id, q1_option2.id ] }, use_route: :answers }
        assignment1.answered_options.should include(q1_option1)
        assignment1.answered_options.should include(q1_option2)
      end

      it 'should remove old answers for answered questions' do
        assignment1.answers << create(:answer, user_id: user.id, option_id: q1_option1.id)

        post :create, params: { answers: { assignment1.id => [ q1_option2.id ] }, use_route: :answers }
        assignment1.answered_options.should == [q1_option2]
      end

      it 'should not create an answer with a blank select' do
        Answer.count.should == 0  # sanity check
        expect {
          post :create, params: { answers: { assignment1.id => [ '' ] }, use_route: :answers }
        }.not_to change(Answer, :count)
      end

      context 'when we post a valid date' do
        let(:valid_date){ { year: '2012', month: '08', day: '12' } }

        it 'should save the date' do
          expect {
            post :create, params: { answers: { date_assignment.id => [ valid_date ] }, use_route: :answers }
          }.to change(Answer, :count).by(1)

          Answer.first.message.should == '2012-08-12'
          Answer.first.date_answer.should == Date.parse('2012-08-12')
        end

        context 'when responding to html' do
          it 'should redirect' do
            post :create, params: { answers: { date_assignment.id => [ valid_date ] }, use_route: :answers }
            response.should redirect_to '/foo'
          end
        end

        context 'when responding to json' do
          it 'should return json' do
            post :create, params: { answers: { date_assignment.id => [ valid_date ] }, use_route: :answers, format: :json }
            response.status.should eq 200
            warning = JSON.parse(response.body)['message']
            warning.should be_nil
          end
        end
      end

      context 'when we post an invalid date' do
        let(:invalid_date){ { year: '2012', month: '28', day: '12' } }

        it 'should not save the date' do
          expect {
            post :create, params: { answers: { date_assignment.id => [ invalid_date ] }, use_route: :answers }
          }.not_to change(Answer, :count)
        end

        context 'when responding to html' do
          it 'should give a warning' do
            post :create, params: { answers: { date_assignment.id => [ invalid_date ] }, use_route: :answers }
            response.should redirect_to '/foo'
            flash[:warn].should == 'Could not save date. You did not select all three fields or you entered an invalid date.'
          end
        end

        context 'when responding to json' do
          it 'should give a warning' do
            post :create, params: { answers: { date_assignment.id => [ invalid_date ] }, use_route: :answers, format: :json }
            response.status.should eq 200
            warning = JSON.parse(response.body)['message']
            warning.should == 'Could not save date. You did not select all three fields or you entered an invalid date.'
          end
        end
      end
    end
  end
end
