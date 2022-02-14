class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :online
end
