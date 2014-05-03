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

  bustedHand: ->
    console.log 'Busted'
    @trigger 'bust', @
    #Reset game

  winningHand: ->
    console.log 'Winner'
    @trigger 'bust', @

  losingHand: ->
    console.log 'l0000z3rrrrrrrrrrr'

  compareHand: (handArray)->
    oneHand = handArray[0]
    otherHand =  21
    otherHand ?= handArray[1]
    if (21-oneHand)<(21-otherHand) then winner = otherHand
    else winner = oneHand

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


    #if playerHand > dealerHand then @winningHand()
    #else @losingHand()


    # TOMORROW
    # stop game @ bust or restart?
    # if dealer bust he loses and i win
