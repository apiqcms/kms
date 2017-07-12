module ControllerMacros

  def login_user
    login(:user)
  end

  def login_admin
    login(:admin)
  end

  def login(role=:admin)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:kms_user]
      user = FactoryGirl.create(role)
      # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
end
