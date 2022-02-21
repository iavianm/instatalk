App.online = App.cable.subscriptions.create "OnlineChannel",
  connected: ->
# Called when the subscription is ready for use on the server
    console.log('Connected to OnlineChannel')

  disconnected: ->
# Called when the subscription has been terminated by the server
    console.log('Disconnected from OnlineChannel')

  received: (data) ->
    current_user = data.user
    element_user = $("#online").find("[data-id=#{current_user.id}]")

    if current_user.online && element_user.length == 0
      $("#online").append("<li data-id=#{current_user.id}>#{current_user.nickname}</li>")
    else if !current_user.online && element_user.length > 0
      element_user.remove()
