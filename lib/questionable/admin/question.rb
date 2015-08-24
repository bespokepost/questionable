if defined?(ActiveAdmin)
  # NOTE: This ":as" option determines the names of the routes generated
  ActiveAdmin.register Questionable::Question, :as => 'Questions' do
    menu :label => 'Questions', :parent => 'Questionable'

    filter :title
    filter :note
    filter :category
    filter :input_type

    form as: :questionable_question do |f|
      f.inputs do
        f.input :title
        f.input :note
        f.input :category
        f.input :input_type, :as => :select,
          :collection => %w(select radio checkboxes multiselect date string statement), :include_blank => false
      end
      f.actions
    end

    show do |q|
      attributes_table do
        row :id
        row :title
        row :note
        row :category
        row :input_type
      end

      panel 'Options', class: 'options' do
        table_for(q.options) do
          column(:id) { |o| link_to o.id, admin_option_path(o) }
          column :title
          column :note
          column :position
          column(:actions) do |o|
            link_to('Edit', edit_admin_option_path(o)) + ' | ' +
            link_to('Delete', admin_option_path(o), :method => :delete)
          end
        end

      end

      panel 'Add Option', class: 'add-option' do
        render partial: 'admin/options/form', locals: { question: q }
      end

    end
  end
end
