# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'game', game = new GameModel()
    @get('game').on 'gameEnded', ->
      location.reload()


