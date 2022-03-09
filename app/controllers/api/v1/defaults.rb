module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json
        formatter :json, Grape::Formatter::ActiveModelSerializers
        helpers do
          def authenticate_user!
            token = request.headers["Jwt-Token"]

            if jwt_auth = JwtAuth.find_by(token: token)
              user_with_token = jwt_auth.user
              if user_with_token.id == JsonWebToken.decode(token)["user_id"]
                @current_user = user_with_token
                return
              end
            end

            api_error! I18n.t("api.v1.login_error")
          end

          def api_error! message, code = I18n.t("api.v1.error_code")
            object_error = {message: message, code: code}
            error! object_error
          end
        end
      end
    end
  end
end
