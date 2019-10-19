class ItemsController < ApplicationController

  get "/items" do
    @items = Item.all
    erb :"items/index"
  end

  get "/items/new" do
    if logged_in?
      erb :"/items/new"
    else
      flash[:error] = "You must be logged in or signed up to create an item."
      redirect '/'
    end
  end

  post "/items" do
    @item = Item.new(title: params[:title], user_id: current_user.id)
    if @item.save
      flash[:message] = "Item added!"
      redirect "/items/#{@item.id}"
    else
      flash[:error] = "Item creation errors: #{@item.errors.full_messages.to_sentence}"
      redirect 'items/new'
    end
  end

  get "/items/:id" do
    @item = Item.find(params[:id])
    erb :"/items/show"
  end

  get '/items/:id/edit' do
    @item = Item.find(params[:id])
    if authorized_to_edit(@item)
      erb :'/items/edit'
    else
      flash[:error] = "Not authorized to edit this item."
      redirect "/items"
    end
  end

  patch '/items/:id' do
    @item = Item.find(params[:id])
    @item.update(title: params[:title])
    redirect "/items/#{@item.id}"
  end

  delete '/items/:id' do
    @item = Item.find(params[:id])
    @item.destroy
    redirect '/items'
  end

end
