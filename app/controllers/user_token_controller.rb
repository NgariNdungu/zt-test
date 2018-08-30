class UserTokenController < Knock::AuthTokenController
  # enable passing parameters without the 'auth' root element
  wrap_parameters :auth, include: [:email, :password]
end
