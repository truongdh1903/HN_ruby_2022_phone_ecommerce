module API
  module V1
    class Auth < Grape::API
      include API::V1::Defaults

      helpers do
        def create_jwt_token user
          token = JsonWebToken.encode(user_id: user.id)
          user.build_jwt_auth(token: token).save
          token
        end
      end

      resource :auth do
        desc "login user"
        params do
          requires :email
          requires :password
        end
        post "/login", root: :auth do
          user = User.find_for_authentication(email: params[:email])

          if user.valid_password?(params[:password])
            present Jwt_Token: create_jwt_token(user)
          else
            api_error! I18n.t("api.v1.invalid_user")
          end
        end

        desc "logout user"
        delete "/logout", root: :auth do
          authenticate_user!
          @current_user.jwt_auth.destroy
          present message: I18n.t("api.v1.logout")
        end
      end
    end
  end
end
