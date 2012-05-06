CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
    :region                 => ENV['S3_REGION']
  }
  config.fog_directory  = Krum.config.s3_bucket_name
  config.fog_host       = "http://#{Krum.config.s3_bucket_name}.s3.amazonaws.com"
  config.fog_public     = false
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end
