class Auth0Controller < ApplicationController
  def callback
    auth_info = request.env['omniauth.auth']
    session[:userinfo] = auth_info['extra']['raw_info']

    redirect_to dashboard_path
  end

  def failure
  end

  def logout
    session[:userinfo] = nil
    url = URI::HTTPS.build(
      host: Rails.application.credentials.auth0[:domain],
      path: '/v2/logout',
      query: {
        returnTo: root_url,
        client_id: Rails.application.credentials.auth0[:client_id]
      }.to_query
    ).to_s
    redirect_to url, allow_other_host: true, status: :see_other
  end
end
