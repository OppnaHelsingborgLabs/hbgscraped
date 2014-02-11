Hbglab::Application.routes.draw do
  namespace :v1 do
    match "detaljplaner" => "detaljplaner#index", :via => :get
    match "test" => "detaljplaner#test", :via => :get
    match "evenemang" => "evenemang#index", :via => :get
    match "skolmat" => "skolmat#index", :via => :get
  end
end
