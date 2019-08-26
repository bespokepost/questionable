# https://robots.thoughtbot.com/test-rake-tasks-like-a-boss
require 'rake'

shared_context 'rake' do
  let(:rake)      { Rake::Application.new }
  let(:task_name) { self.class.metadata[:full_description].split(' ').detect { |name| rake.lookup(name) } }
  let(:task_path) { "lib/tasks/#{self.class.metadata[:full_description].split(' ').first}" }
  subject         { rake[task_name] }

  def root_path
    Rails.root.sub('spec/dummy', '')
  end

  def loaded_files_excluding_current_rake_file
    $".reject { |file| file == root_path.join("#{task_path}.rake").to_s }
  end

  before do
    Rake.application = rake
    Rake.application.rake_require(task_path, [root_path.to_s], loaded_files_excluding_current_rake_file)
    Rake::Task.define_task(:environment)
  end
end
