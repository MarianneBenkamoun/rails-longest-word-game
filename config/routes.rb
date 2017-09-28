Rails.application.routes.draw do
  get 'wordgame/score'

  get 'wordgame/game'

  get 'score', to: 'wordgame#score'
  get 'game', to: 'wordgame#game'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
