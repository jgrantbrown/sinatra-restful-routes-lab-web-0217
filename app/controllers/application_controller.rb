class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipes = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{@recipes.id}"
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/:id' do
    @recipe=Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do #load edit form
      @recipe = Recipe.find(params[:id])
      erb :edit
    end

  patch '/recipes/:id' do #edit action
      @recipe=Recipe.find(params[:id])
      @recipe.name= params[:name]
      @recipe.ingredients= params[:ingredients]
      @recipe.cook_time=params[:cook_time]
      @recipe.save
      redirect "/recipes/#{@recipe.id}"
    end

  delete '/recipes/:id/delete' do
  
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    erb :deleted
  end

end
