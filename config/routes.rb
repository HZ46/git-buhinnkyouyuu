Rails.application.routes.draw do
  root 'homes#top' #homesコントローラはadminとdepartmentの外にあるからこのような書き方になる

  devise_for :department, controllers: {
    sessions: "department/sessions"
  }

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }


  # get 'search' => 'search#search'

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    get 'search' => 'items#search', as: 'search'
    #get 'customers/:customer_id/orders' => 'orders#index', as: 'customer_orders'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, except: [:destroy]
    resources :orders, only: [:index, :show, :update]
    resources :production, only: [:update]
    resources :departments do
      get :search, on: :collection
    end
    resources :order_details, only: [:update]
  end

  scope module: :department do
    get 'search' => 'items#search', as: 'search'
    get 'department/mypage' => 'departments#show', as: 'departmentpage'
    # customers/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    #get 'users/information/edit' => 'users#edit', as: 'edit_information'
    #patch 'customers/information' => 'customers#update', as: 'update_information'
    #put 'customers/information' => 'customers#update'
    get 'orders/confirmation' => 'orders#confirmation'
   # post 'orders/confirm' => 'orders#confirm'
    get 'orders/thanks' => 'orders#thanks', as: 'thanks'
    resources :items, only: [:index, :show] do #do~endがここでくくられているのか理由を聞く #なぜ37行目と39行目は分けてあるのか聞く
      resource :bookmarks, only: [:create, :destroy]
      #resources :cart_items, only: [:create, :update, :destroy]
    end
    resources :cart_items, only: [:create, :update, :index, :destroy]
    #resources :cart_items, only: [:index]
    resources :orders, only: [:index, :create, :show] do
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
