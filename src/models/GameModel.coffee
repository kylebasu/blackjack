class window.GameModel extends Backbone.Model
  initialize: ->
    that = @
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'cardServed', ->
      if @scores()[0] > 21
        alert 'Busted'
        that.trigger 'gameEnded', @

    @get('dealerHand').on 'cardServed', ->
      if @getTrueScore() > 21
        alert 'you win!!!'
        that.trigger 'gameEnded', @
      else if @getTrueScore() > that.get('playerHand').getTrueScore()
        alert 'You lose :('
        that.trigger 'gameEnded'
      else if @getTrueScore() < that.get('playerHand').getTrueScore()
        alert 'You win!!!'
        that.trigger 'gameEnded'

    return



