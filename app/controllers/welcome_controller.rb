class WelcomeController < ActionController::API
  def index
    render json: "Welcome to the API".to_json
  end
end
