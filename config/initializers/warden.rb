Rails.application.config.middleware.insert_after ActionDispatch::Session::CookieStore, Warden::Manager do |manager|
  manager.default_strategies :password, :cookie
  manager.failure_app = lambda { |env| SessionsController.action(:new).call(env) }
end

Warden::Manager.serialize_into_session do |user|
  user.generate_session_token!
end

Warden::Manager.serialize_from_session do |session_token|
  User.find_by(session_token: session_token)
end

Warden::Manager.after_authentication scope: :user do |user, auth, opts|
  request.session['session_token'] = user.generate_session_token!
end

Warden::Manager.before_logout scope: :user do |user, auth, opts|
  user.update_attribute :session_token, nil
end

Warden::Strategies.add(:password) do
  def valid?
    params['email'] && params['password']
  end

  def authenticate!
    user = User.find_by(email: params['email'])
    return success!(user) if user && user.authenticate(params['password'])
    fail 'Invalid email or password'
  end
end

Warden::Strategies.add(:cookie) do
  def valid?
    request.session['session_token']
  end

  def authenticate!
    user = User.find_by(session_token: request.session['session_token'])
    return success!(user) if user
    fail! "Could not log in"
  end
end
