require 'sidekiq'

# Sidekiq.configure_client do |config|
#   config.redis = { size: 1 }
# end



redis_conn = proc {
  Redis.new # do anything you want here
}
Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 3, &redis_conn)
end


