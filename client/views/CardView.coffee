class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<img src="../2014-04-blackjack/img/cards/<%= rankName %>-<%= suitName %>.png"></img>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.html @template @model.attributes
    @$el.html '<img src="../2014-04-blackjack/img/card-back.png"></img>' unless @model.get 'revealed'
