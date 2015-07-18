class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('game').get('playerHand').hit()
    'click .stand-button': -> @model.get('game').get('playerHand').stand()
    'click .stand-button': -> @model.get('game').get('dealerHand').play()

  initialize: ->
    @render()
    if @model.get('game').get('playerHand').scores()[0] == 21 or @model.get('game').get('playerHand').scores()[1] == 21
        console.log 'BlackJack !!!!!!! :D'
        @model.trigger 'gameEnded', @

    @model.on('newGame', =>
      console.log('ended')
      @render()
    )

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get('game').get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get('game').get 'dealerHand').el

