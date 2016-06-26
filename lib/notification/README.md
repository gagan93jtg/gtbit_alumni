# Notification Pipeline Design

### Useful [link](http://redis.io/topics/data-types)


### Every query will have a redis SET

  * DataType : Set (we need unique, unordered collection)

  * Key name : QUERY\_SUBSCRIBERS:query\_id

  * Stores : IDs of all the users who have commented on that query atleast once.

  * Useful commands : SADD, SMEMBERS, SPOP

  * Write : Whenever somebody comments on a post, make an entry in this set

  * Read : After writing, read this set again and create notifications for all those IDs

### Every user will have two redis HASHES

  * DataType : HASH (Key value pairs)

  * Key names : UNREAD\_NOTIFS:user_id, READ\_NOTIFS:user_id

  * Stores : READ\_NOTIFS is a hash which stores no. of read notifications for all users
             UNREAD\_NOTIFS is a hash which stores no. of unread notifications for all users

  * Useful commands : HDEL, HSET, HKEYS, HGET, HGETALL, HMSET, HLEN

  * Write : Write UNREAD\_NOTIFS:<user_id> hash whenever any user makes comment on a subscribed post
            Write READ\_NOTIFS:<user_id> hash after showing all notifications to user

  * Read : Read both hashes whenever user hits index action of notifications controller
