class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    if @scores()[0] < 21
      @add(@deck.pop())
      if not @isDealer
        @trigger 'cardServed', @

      @last()

  stand: ->

  play: ->
    if @isDealer
      @first().flip()
      
      while @getTrueScore() < 17
        @hit()

      @trigger 'cardServed', @

      return
  hasAce: -> @reduce (memo, card) ->
    memo or (card.get('value') is 1 and card.get('revealed') )
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  getTrueScore: ->
    if @hasAce and @scores()[1] > 21
      score = @scores()[0]
    else
      score = @scores()[1]
    score

