# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "welcome#index"

  resource :account, only: [:new, :create, :show, :update, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :questions, only: [:new, :create, :edit, :update] do
    resources :answers, only: [:new, :create, :edit, :update], shallow: true
  end

  constraints AdminConstraint.new do
    mount MissionControl::Jobs::Engine, at: "jobs"
  end
end
