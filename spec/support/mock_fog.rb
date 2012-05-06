Fog.mock!
fog_credentials = {
  :provider               => 'AWS',
  :aws_access_key_id      => 'xxx',
  :aws_secret_access_key  => 'yyy'
}

CarrierWave.configure do |config|
  config.fog_credentials = fog_credentials
end
connection = Fog::Storage.new(fog_credentials)
connection.directories.create(:key => Krum.config.s3_bucket_name)
