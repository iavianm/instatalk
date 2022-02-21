class OnlineChannel < ApplicationCable::Channel
  def subscribed
    logger.info 'Subscribed to OnlineChannel'

    stream_from 'online_channel'

    OnlineService.new(current_user).make_online
  end

  def unsubscribed
    logger.info 'Unsubscribed to OnlineChannel'

    OnlineService.new(current_user).make_offline
  end
end
