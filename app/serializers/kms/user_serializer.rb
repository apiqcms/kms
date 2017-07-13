module Kms
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :role, :localized_role
  end
end
