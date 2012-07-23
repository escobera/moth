Dummy::Application.routes.draw do
  match "test_named_route/:controller/:action", :to => "DummiesController", :as => :test_named_route
  moth_routes
end
