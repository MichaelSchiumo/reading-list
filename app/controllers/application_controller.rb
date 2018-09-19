require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret_password"
  end

  helpers do
    def current_user
      @user = User.find_by(id: session[:user_id])
    end

    def logged_in?
      !!current_user
    end

    def logout
      session.clear
    end
  end

end
