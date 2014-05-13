module OauthHelpers
  def auth_data
    user = attributes_for(:user)

    OmniAuth::AuthHash.new(
      {
        provider: user[:provider],
        uid: user[:uid].to_s,
        info: {
          name: user[:name],
          image: user[:profile_image],
          email: user[:email]
        },
        credentials: {
          token: user[:oauth_token],
          expires_at: user[:oauth_expires_at].to_i
        }
      }
    )
  end

  def invalid_auth_data
    user = attributes_for(:user)

    OmniAuth::AuthHash.new(
      {
        provider: user[:provider],
        uid: user[:uid],
        info: { name: "", image: "", email: "" },
        credentials: { token: "", expires_at: 0 }
      }
    )
  end

  def sign_in_with_facebook
    OmniAuth.config.mock_auth[:facebook] = auth_data
    click_link "Sign in with Facebook"
  end
end
