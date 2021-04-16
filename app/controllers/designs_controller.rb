class DesignsController < ApplicationController
    get '/designs' do
        redirect_if_not_logged_in

        @designs = current_user.designs
        erb :'designs/index'
    end

    get '/designs/new' do
        redirect_if_not_logged_in

        erb :'designs/new'
    end

#designs per order and per location. associate each design to a location and order if there is any.
get '/designs/orlo' do 
    #all designs 
    @designs = Design.all
    #render a form  
    erb :'designs/orlo'
end

#to see all designs 
get '/designs/all' do 
    @designs = Design.all
    erb :'designs/all'
end

#to see all designs that are associated to locations
get '/designs/loc' do 
    #first find all designs 
    @designs = Design.all
    #then render it 
    erb :'design/location'
end




    get '/designs/:id' do
        redirect_if_not_logged_in
        redirect_if_not_authorized

        erb :'designs/show'
    end











    post '/designs' do
        redirect_if_not_logged_in



        design = current_user.designs.build(params["design"])

        if design.save
            redirect "/designs/#{design.id}"
        else
            flash[:error] = "#{design.errors.full_messages.join(", ")}"
            redirect "/designs/new"
        end
    end

    get '/designs/:id/edit' do
        redirect_if_not_logged_in
        redirect_if_not_authorized

        erb :'designs/edit'
    end

    patch '/designs/:id' do
        redirect_if_not_logged_in
        redirect_if_not_authorized
        
        if @design.update(params["design"])
            redirect "/designs/#{@design.id}"
        else
            redirect "/designs/#{@design.id}/edit"
        end
    end


    delete "/designs/:id" do
        redirect_if_not_logged_in
        redirect_if_not_authorized

        @design.destroy

        redirect "/designs"
    end

    private
 
    def redirect_if_not_authorized
        @design = Design.find_by_id(params[:id]) 
        if @design.user_id != session["user_id"] 
            redirect "/designs"
        end
    end
end

