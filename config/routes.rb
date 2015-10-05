Rails.application.routes.draw do


  get 'data/acceleration' => 'tracking#accelerations', as: 'accelerations'
  get 'data/activity' => 'tracking#activities', as: 'activities'

  post '/' => 'tracking#incoming', as: 'post_root'
  root to: 'tracking#test'
end
