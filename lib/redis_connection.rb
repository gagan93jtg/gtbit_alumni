class RedisConnection
  def self.initialize_redices
    master = CONFIG['redis_master']
    slave = CONFIG['redis_slave']
    master_redis = Redis.new(host: master['host'], port: master['port'], db: master['db'])
    slave_redis  = Redis.new(host: slave['host'], port: slave['port'], db: slave['db'])

    return master_redis, slave_redis
  end
end
