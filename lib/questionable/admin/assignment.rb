if defined?(ActiveAdmin)
  ActiveAdmin.register Questionable::Assignment, :as => 'Assignments', :sort_order => 'source_type, source_id, position' do
    menu :label => 'Assignments', :parent => 'Questionable'

    controller do
      def scoped_collection
        super.includes :question
      end
    end

    filter :subject_type
    filter :question
    filter :answered_options
    filter :position
    filter :created_at
    filter :updated_at

    index do 
      column(:id) { |a| link_to a.id, admin_assignment_path(a.id) }
      column(:subject) { |a| a.subject_id ? a.subject : a.subject_type }
      column :position
      column(:question) { |a| a.question.title }
      column :created_at
      column :updated_at
    end

    form as: :questionable_assignment do |f|
      f.inputs do
        f.input :question
        f.input :subject_type
        f.input :subject_id, :as => :number
        f.input :position
      end
      f.actions
    end
  end
end
