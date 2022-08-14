Faraday.default_adapter = :net_http

class ChatsController < ApplicationController
    before_action :setupRedis

    def create 
        value=get_chats_number
        ## Todo message queue
        render(json: {"chat number": value}, status: :ok)
      
    end

    def get_chats_number
        key=params[:password_reset_token]
        servers = [@redis]
        value=@redis.get(key)
        if !value.nil?
            # @redis.set(key,value.to_i+1, :keepttl => true)
            # incr does not change the existance ttl 
            #Redis is a single-threaded engine, so the execution of all commands is serialized. It always provides atomicity and isolation 
            #(in the sense of ACID) for each individual command.
            #The consequence is applying a single INCR command and exploiting its result is safe (even if multiple connections do it concurrently).
            value =@redis.incr(key)
            puts "value got from redis #{value}"
            puts @redis.ttl(key)
        else
            puts "value does not exist in redis so fteching from api"
            # aquiring a lock on the redis cache for more Concurrency  controll
            #retry_count` being how many times it'll try to lock a resource (default: 3)
            #`retry_delay` being how many ms to sleep before try to lock again (default: 200)
            #`retry_jitter` being how many ms to jitter retry delay (default: 50)
            #`redis_timeout` being how the Redis timeout will be set in seconds (default: 0.1)
            lock_manager = Redlock::Client.new(
                servers, {
                retry_count:   3,
                retry_delay:   3000, # milliseconds
                retry_jitter:  50,  # milliseconds
                redis_timeout: 0.1  # seconds
               })
            # block version that automatically unlocks the lock:
            lock_manager.lock(key, 10000) do |locked|
                if locked
                  #critical code
                  #call the main api to get the chat_count
                  response = Faraday.get("http://chat-system-service:3000/applications/#{params[:password_reset_token]}/")
                  value= JSON.parse(response.body)["body"]["chats_count"]
                  # add value to redis using expiration time of 1.hours
                  @redis.setex(key,1.hour,value.to_i+1)
                  puts "value got from api #{@redis.get(key)}"
                  value= @redis.get(key)
                end
            end
        end
        value
    end

    private def setupRedis
        @redis = Redis.new(host: 'redis', port: 6379, db: 1)
    end


end
