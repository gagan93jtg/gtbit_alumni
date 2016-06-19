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

  * Key names : UNREAD\_NOTIFS, UNREAD\_NOTIFS:user\_id

  * Stores : UNREAD\_NOTIFS:user\_id stores complete information about a notification in JSON format.
             UNREAD\_NOTIFS is a hash which stores no. of unread notifications for all users

  * Useful commands : HDEL, HSET, HKEYS, HGET, HGETALL, HMSET, HLEN

  * Write : Increment hash position of user inside UNREAD\_NOTIFS whenever comment is made for a subscribed post
            Write UNREAD\_NOTIFS:<user_id> list whenever any user makes comment on a subscribed post

  * Read : Read UNREAD\_NOTIFS whenever user log's in and clear it once user opens notifications/index
           Read UNREAD\_NOTIFS:<user_id> whenver user tries to see 'all notifications' page.
