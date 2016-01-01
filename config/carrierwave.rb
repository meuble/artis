require 'carrierwave/orm/activerecord'

s3_config = {}

if File.exists?(File.expand_path("../fog.yml", __FILE__))
  s3_config = YAML.load_file(File.expand_path("../fog.yml", __FILE__)).symbolize_keys
end

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => s3_config[:key] || ENV['S3_KEY'],
    :aws_secret_access_key  => s3_config[:secret] || ENV['S3_SECRET'],
    :region                => s3_config[:region] || ENV['S3_REGION'],
    :endpoint               => s3_config[:endpoint] || ENV['S3_ENDPOINT']
  }
  config.fog_directory  = s3_config[:bucket] || ENV['S3_BUCKET']
  config.fog_public     = true
end