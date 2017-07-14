Rails.application.config.middleware.insert_after ActionDispatch::Session::CookieStore, Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = lambda { |env| SessionsController.action(:new).call(env) }
end

Warden::Manager.serialize_into_session do |user|
  User::SessionTokenGenerator.new(user).call
end

Warden::Manager.serialize_from_session do |session_token|
  User.find_by(session_token: session_token)
end

Warden::Manager.before_logout scope: :user do |user, auth, opts|
  user.update(session_token: nil)
end

Warden::Strategies.add(:password) do
  def valid?
    params['email'] && params['password']
  end

  def authenticate!
    user = User.find_by(email: params['email'])
    return success!(user) if user && User::Authenticate.new(user, params['password']).call
    fail 'Invalid email or password'
  end
end
