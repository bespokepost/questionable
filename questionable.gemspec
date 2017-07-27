$:.push File.expand_path('../lib', __FILE__)

require 'questionable/version'

Gem::Specification.new do |s|
  s.name        = 'questionable_surveys'
  s.version     = Questionable::VERSION
  s.authors     = ['Nick Urban, Dorian Marié, Jared Hales']
  s.email       = ['nick@nickurban.com, dorian@bespokepost.com, jared@bespokepost.com']
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/bespokepost/questionable'
  s.summary     = 'Rails engine that programatically generates surveys.'
  s.description = 'Makes it easy to add and edit forms programatically, ' +
    'specifying select, radio, checkbox, or string input, ' +
    'and recordings users answers. ' +
    'Questions can be associated with specific objects or with string labels. ' +
    'A form template and controller are including for displaying questions and recording answers, ' +
    'and ActiveAdmin is supported for editing the questions and options on the back-end.'


  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 5'
  s.add_dependency 'haml'
  s.add_dependency 'formtastic'
  s.add_dependency 'stringex'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
end
