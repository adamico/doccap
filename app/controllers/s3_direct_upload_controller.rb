require 'fog'
class S3DirectUploadController < ApplicationController
  def destroy
    if params[:filepath].present?
      s3 = Fog::Storage::AWS.new(
        aws_access_key_id: S3DirectUpload.config.access_key_id,
        aws_secret_access_key: S3DirectUpload.config.secret_access_key)
      bucket = S3DirectUpload.config.bucket
      file = s3.directories.get(bucket).files.get(params[:filepath])
      file.destroy
    end

    respond_to do |format|
      format.js
    end
  end
end
