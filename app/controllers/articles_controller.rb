class ArticlesController < ApplicationController
  
  get '/articles' do
    @articles = Article.all
    erb :'articles/index'
  end

  get '/articles/new' do
    erb :'articles/new'
  end

  get '/artices/:id' do
    @article = article.find(params[:id])
    erb :'articles/show'
  end

  get '/artices/:id/edit' do
    @article = article.find(params[:id])
    erb :'articles/edit'
  end

  # post '/articles' do
  #   @article = article.create(params['article'])
  #   unless params[:landmark][:name].empty?
  #     @article.landmarks << Landmark.create(params[:landmark])
  #   end

    unless params[:title][:name].empty?
      @article.titles << Title.create(params[:title])
    end

    @article.save
    redirect to "/articles/#{@article.id}"
  end

  patch '/artices/:id' do
    @article = article.find_by_id(params[:id])
    @article.update(params[:article])
    unless params[:title][:name].empty?
      @article.titles << Title.create(params[:title])
    end

    # unless params[:landmark][:name].empty?
    #   @article.landmarks << Landmark.create(params[:landmark])
    # end
    
    @article.save
    redirect to "/articles/#{@article.id}"
  end

end