class AvatarUploader < CarrierWave::Uploader::Base
  storage :grid_fs

  def default_url
    "/assets/group/fallback/default.png"
  end
end
