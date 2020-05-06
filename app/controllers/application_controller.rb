class ApplicationController < ActionController::API

  def authorize_admin
    return true if ENV['REQUIRE_AUTHORIZE'] == '0'

    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @jwt_decoded = JsonWebToken.decode(header)
      if @jwt_decoded[:role] != 'admin'
        render json: {errors: 'No Permission.'}, status: :forbidden
      end
    rescue JWT::DecodeError => e
      render json: {errors: "JWT DecodeError: #{e.message}"}, status: :unauthorized
    end
    true
  end

  def require_authorization?
    ENV['REQUIRE_AUTHORIZE'] != '0'
  end
end
