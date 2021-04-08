class ApplicationController < Sinatra::Base
  # set :views, Proc.new { File.join(root, "../views") }
  
  configure do
      set :views, 'app/views'
      set :public_folder, 'public'
      enable :sessions
      set :session_secret, ENV['SESSION_SECRET']
  end
#   ccccccccgit
  get '/' do
      erb :search
  end

  get '/search' do
     @design = Design.find_by(title: params["title"])
     erb :results
  end

  helpers do
      def current_user
          # memoization
          @current_user ||= User.find_by_id(session["user_id"])
      end

      def logged_in?
          !!current_user
      end

      def redirect_if_not_logged_in
          redirect "/login" if !logged_in?
      end

      def redirect_if_logged_in
          redirect "/design" if logged_in?
      end
  end
end

#checking to see if committed
#asty ya ni


#hi are you there