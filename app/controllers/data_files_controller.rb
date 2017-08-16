class DataFilesController < ApplicationController
  def show
    render json: session[:autocomplete_data_file]
  end
end
