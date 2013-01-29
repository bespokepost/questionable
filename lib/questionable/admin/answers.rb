if defined?(ActiveAdmin)
  ActiveAdmin.register Questionable::Answer, :as => 'Answers' do
    menu :label => 'Answers', :parent => 'Questionable'

    filter :user_email, :as => :string
    filter :assignment_sources
    filter :created_at
    filter :updated_at

    index do
      column(:id) { |a| link_to a.id, admin_answer_path(a) }
      column(:user) 
      column(:assignment)
      column(:option)
      column(:message)
      default_actions
    end
  end
end
