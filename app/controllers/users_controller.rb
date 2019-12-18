class UsersController < ApplicationController

	get '/login' do
	  if logged_in?
        redirect '/items'
	  else
	    erb :'/users/login'
	  end
	end

	post '/login' do
	  @user = User.find_by(email: params[:email])
	   if @user && @user.authenticate(params[:password])
	      session[:user_id] = @user.id
	      flash[:message] = "Welcome, #{@user.name}"
	      redirect "/users/#{@user.id}"
	   else
	      flash[:error] = "Login credentials were invalid. Please try again."
	      redirect "/login"
	   end
	end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get "/users/:id" do
	 @user = User.find_by(id: params[:id])
	 erb :'/users/show'
  end


  get '/signup' do
    erb :'/users/signup'
  end

  post '/users' do
    @user = User.new(params)
    if User.find_by(email: @user.email)
      flash[:error] = "Error: The username you entered already exists. Please enter a different username."
      redirect "/signup"
    elsif @user.email != "" && @user.password != "" && @user.save
      session[:user_id] = @user.id
      redirect "/items"
    else
      flash[:error] = "Please fill in all fields."
      redirect "/signup"
    end
  end

end
