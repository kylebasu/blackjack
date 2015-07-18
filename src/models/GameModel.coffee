class window.GameModel extends Backbone.Model
  initialize: ->
    that = @
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @addEventToHand();

    return

  addEventToHand: ->
    @get('playerHand').on 'cardServed', =>
      if @get('playerHand').scores()[0] > 21
        alert 'Busted'
        @trigger 'gameEnded', @

    @get('dealerHand').on 'cardServed', =>
      if @get('dealerHand').getTrueScore() > 21
        alert 'you win!!!'
        @trigger 'gameEnded', @
      else if @get('dealerHand').getTrueScore() > @get('playerHand').getTrueScore()
        alert 'You lose :('
        @trigger 'gameEnded'
      else if @get('dealerHand').getTrueScore() < @get('playerHand').getTrueScore()
        alert 'You win!!!'
        @trigger 'gameEnded'
      else if @get('dealerHand').getTrueScore() == @get('playerHand').getTrueScore()
        alert 'its a PUSH'
        @trigger 'gameEnded'



