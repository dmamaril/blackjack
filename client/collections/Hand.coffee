class window.Hand extends Backbone.Collection

  model: Card

  checkScore: ->
    scoreToCheck = do @scores
    console.log scoreToCheck
    if scoreToCheck[0] > 21 then do @bust
    else if scoreToCheck[1] is 21 or scoreToCheck[0] is 21
      do @win

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    do @checkScore

  bust: ->
    @trigger 'bust', @


  stand: ->

    @trigger 'stand', @



  win: ->
    @trigger 'win', @

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
