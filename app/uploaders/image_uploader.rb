# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base



  # Include RMagick or MiniMagick support:
  include CarrierWaveDirect::Uploader 
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # config.will_include_content_type = true

  # config.default_content_type = 'video/mpeg'
  # config.allowed_content_types = %w(video/mpeg video/mp4 video/ogg)

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog
  # using fog
 # include CarrierWave::MimeTypes 
 # process :set_content_type 

 # def download_url(filename)
 #  url(response_content_disposition: %Q{attachment; filename="#{filename}"})
 # end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fill => [410, 380]
  end



  # def filename 
  #  if original_filename 
  #    @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
  #    "#{@name}.#{file.extension}"
  #  end

  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
