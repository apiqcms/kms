module Kms
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

    ROLES = %i[admin content_manager]

    def admin?
      role == "admin"
    end

    def localized_role
      I18n.t("roles.#{role}")
    end
  end
end
