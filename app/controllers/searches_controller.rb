class SearchesController < ApplicationController
  def show
    @query = params[:search][:query]
    @results = Image.search(params[:search]).includes(gallery:[:user])
  end
end
