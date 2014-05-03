#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model



  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()



    @listenTo @get('playerHand'), 'bust', @bustedHand
    @listenTo @get('playerHand'), 'stand', @stood
    @listenTo @get('playerHand'), 'win', @winningHand
    @listenTo @get('dealerHand'), 'bust', @winningHand

  compareHand: (handArray)->
    oneHand = handArray[0]
    otherHand =  21
    otherHand ?= handArray[1]
    if (21-oneHand)<(21-otherHand) then winner = otherHand
    else winner = oneHand


  bustedHand: ->
    alert 'Busted'
    @trigger 'endGame', @
    #Reset game

  winningHand: ->
    alert 'Winner'
    dealerHand = 0
    @trigger 'endGame', @

  losingHand: ->
    if @get('dealerHand').scores()[0] <= 21 then alert 'l0000z3rrrrrrrrrrr'
    @trigger 'endGame', @

  stood: ->
    # run dealer AI first
    @get('dealerHand').at(0).flip()

    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()
    dealerHand = @compareHand(dealerScore)
    playerHand = @compareHand(playerScore)


    while (playerHand > dealerHand and dealerHand < 21)
      console.log 'Hitting'
      @get('dealerHand').hit()
      dealerScore = @get('dealerHand').scores()
      dealerHand = @compareHand(dealerScore)

    # iterate through @get('playerHand') && ('dealerHand')
    # get highest value less than 22 @getHand(playerCards)


    if playerHand > dealerHand
      #dealerHand = 0
      @winningHand()
    else if dealerHand <= 21
      do @losingHand
    #if dealerHand <= 21 and dealerHand > playerHand then do @losingHand


    # TOMORROW
    # stop game @ bust or restart?
    # if dealer bust he loses and i win
