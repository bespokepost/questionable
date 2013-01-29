Questionable::Engine.routes.draw do
  scope 'assignments/:assignment_id' do
    resources :answers, :only => [:create]
  end

  post 'answers/create_multiple' => 'answers#create_multiple'
end
