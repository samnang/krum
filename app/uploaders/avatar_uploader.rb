class AvatarUploader < CarrierWave::Uploader::Base
  storage :grid_fs

  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/assets/group/fallback/default.png"
  end
end
