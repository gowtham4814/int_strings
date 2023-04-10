Rails.application.routes.draw do
  root to: 'posts#all_post'
  devise_for :users
  resources :topics do
    resources :posts
  end
  get "/users/edit", to: "users#edit", as: "edit_user"
  patch "/users", to: "users#update", as: "user"
  post '/topics/:topic_id/posts/:post_id/comments', to: 'comment#create', as: 'topic_post_comments'
  post '/topics/:topic_id/posts/:post_id/ratings', to: 'rating#create', as: 'topic_post_ratings'
  get '/topics/:topic_id/posts/:post_id/comments/edit/:id', to: 'comment#edit', as: 'edit_topic_post_comment'
  put '/topics/:topic_id/posts/:post_id/comments/:id', to: 'comment#update', as: 'topic_post_comment'
  delete '/topics/:topic_id/posts/:post_id/comments/:id', to: 'comment#delete', as: 'topic_post_comment_delete'
  post '/topics/:topic_id/posts/:post_id/comment_rating/:id', to: 'comment#comment_rating', as: 'topic_post_comment_rating'
  get 'topic/:topic_id/posts/:post_id/comment_users/:id', to: 'comment#show', as: 'show_rating'
  post 'topics/:topic_id/posts/:id/read_post', to: 'posts#read_post' , as: 'read_post'
  get '/posts', to: 'posts#all_post', as: 'all_post'
  get '/posts/all', to: 'posts#posts', as: 'posts'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
