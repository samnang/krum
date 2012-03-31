class AvatarUploader < CarrierWave::Uploader::Base
  storage :grid_fs

  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/assets/fallback_group.png"
  end
end
