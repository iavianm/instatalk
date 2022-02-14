class OnlineService
  def initialize(current_user)
    @current_user = current_user
  end

  def make_online
    @current_user.update!(online: true)

    broadcast_users
  end

  def make_offline
    if unique_connections.zero?
      @current_user.update!(online: false)

      broadcast_users
    end
  end

  private

  def broadcast_users
    ActionCable.server.broadcast 'online_channel', user: UserSerializer.as_json
  end

  def unique_connections
    ActionCable.server.connections.count do |connection|
      connection.current_user.id == @current_user.id
    end
  end
end
