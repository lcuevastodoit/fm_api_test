Sidekiq.configure_server do |config|
  config.redis = { network_timeout: 180, url: 'redis://0.0.0.0:6379/0' }
end
Sidekiq.configure_client do |config|
  config.redis = { network_timeout: 180, url: 'redis://0.0.0.0:6379/0' }
end
if true
  redis = Redis.new # inicializa Redis
end
