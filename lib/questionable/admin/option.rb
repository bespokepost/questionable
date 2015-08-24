if defined?(ActiveAdmin)
  # NOTE: This ":as" option determines the names of the routes generated
  ActiveAdmin.register Questionable::Option, :as => 'Options' do
    menu :label => 'Options', :parent => 'Questionable'

    controller do
      def create
        create!(location: request.referrer)
      end

      def update
        update!(location: admin_question_path(resource.question))
      end

      def destroy
        destroy!(location: admin_question_path(resource.question))
      end
    end

    form as: :questionable_option do |f|
      f.inputs do
        f.input :question
        f.input :title
        f.input :note
        f.input :position
      end
      f.actions
    end
  end
end
