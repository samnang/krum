class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :fog

  version :thumb do
    process :resize_to_fit => [300, 200]
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/assets/fallback_group.png"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
