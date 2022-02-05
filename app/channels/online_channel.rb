class OnlineChannel < ApplicationCable::Channel
  def subscribed
    logger.info "Subscribed to OnlineChannel"

    stream_from "online_channel"

    current_user.update!(online: true)
    broadcast_users
  end

  def unsubscribed
    logger.info "Unsubscribed to OnlineChannel"

    current_user.update!(online: false)
    broadcast_users
  end

  private

  def broadcast_users
    ActionCable.server.broadcast "online_channel", users: User.online.pluck(:nickname)
  end
end
