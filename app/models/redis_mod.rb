#  wrapper around a Redis database connection, that we
#  can use as a singleton object application wide
module RedisMod
  @@redis_connection = Redis.new
  def self.conn
    @@redis_connection
  end
end
