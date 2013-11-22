require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  enable_authorization unless: :devise_controller?

  rescue_from CanCan::Unauthorized do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    redirect_to login_url, alert: exception.message
  end


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
