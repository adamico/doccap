require "application_responder"

class ApplicationController < ActionController::Base
  include Pundit

  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :authenticate_user!

  def destroy_fichier(url)
    if url.present?
      s3 = Fog::Storage::AWS.new(
        aws_access_key_id: S3DirectUpload.config.access_key_id,
        aws_secret_access_key: S3DirectUpload.config.secret_access_key)
      file = s3.directories.get(bucket).files.get(get_file_path(url))
      file.destroy
    end
  end

  private

  def user_not_authorized
    flash[:error] = "Vous n'êtes pas autorisé !"
    redirect_to request.headers["Referer"] || root_path
  end

  def get_file_path(url)
    URI.decode(url).gsub(/https:\/\/#{region}.amazonaws.com\/#{bucket}\//, "")
  end

  def region
    @region = S3DirectUpload.config.region
  end

  def bucket
    @bucket = S3DirectUpload.config.bucket
  end
end
