CarrierWave.configure do |config|

   config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'SECRET_KEY',
    :aws_secret_access_key  => 'SECRET_ACCESS_KEY',
  }
  config.fog_directory  = 'thin-upload'
end