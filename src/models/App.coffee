# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'game', game = new GameModel()

    @get('game').on 'gameEnded', =>
      if @get('game').get('deck').length < Math.floor(104 / 3)
        @get('game').set 'deck', new Deck()
      @get('game').set 'playerHand', @get('game').get('deck').dealPlayer()
      @get('game').set 'dealerHand', @get('game').get('deck').dealDealer()

      @get('game').addEventToHand();
      console.log @get('game').get('deck').length
      @trigger 'newGame', @

