CarrierWave.configure do |config|
	# config.storage = :aws
	config.fog_directory =  ENV['AWS_S3_BUCKET_NAME']
	# config.aws_acl    = 'public-read'
	config.fog_credentials = {
		provider: 'AWS',
		aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
		aws_secret_access_key: ENV['AWS_SECRET_KEY'],
		region: ENV['AWS_REGION']
		
	}

	# config.fog_directory =
end