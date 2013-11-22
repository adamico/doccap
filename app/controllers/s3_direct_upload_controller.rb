require 'fog'
class S3DirectUploadController < ApplicationController
  def destroy
    destroy_fichier(params[:filepath])
    respond_to do |format|
      format.js
    end
  end
end
