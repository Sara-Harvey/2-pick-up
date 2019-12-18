class ItemsController < ApplicationController

  get "/items" do
    @items = Item.all
    erb :"/items/index"
  end

  get "/items/new" do
    redirect_if_not_logged_in
    erb :"/items/new"
  end

  post "/items" do
    @item = Item.new(title: params[:title], notes: params[:notes], user_id: current_user.id)
    if @item.save
      flash[:message] = "Item added!"
      redirect "/items/#{@item.id}"
    else
      flash[:error] = "Item creation errors: #{@item.errors.full_messages.to_sentence}"
      redirect 'items/new'
    end
  end

  get "/items/:id" do
    @item = Item.find_by(id: params[:id])
      if !@item 
        flash[:error] = "Item not found."
        redirect "/"
      end
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
    if authorized_to_edit(@item)
    @item.update(title: params[:title], notes: params[:notes])
      redirect "/items/#{@item.id}"
    else 
      flash[:error] = "Not authorized to edit this item."
      redirect "/items"
    end
  end

  delete "/items/:id" do   
    @item = Item.find(params[:id])
    if authorized_to_edit(@item)  
    @item.destroy
      flash[:message] = "Item deleted"
      redirect "/items"
    else 
      flash[:error] = "Not authorized to delete this item."
      redirect "/items"
    end
  end

end
