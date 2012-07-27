Dummy::Application.routes.draw do
  match "test_named_route/:controller/:action", :to => "DummiesController", :as => :test_named_route
  match "crudapp/:controller/:action", :to => "Posts#index", :as => :crud_app
end
