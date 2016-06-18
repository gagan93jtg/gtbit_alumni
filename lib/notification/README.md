# Notification Pipeline Design

### Useful [link](http://redis.io/topics/data-types)


### Every query will have a redis SET

  * DataType : Set (we need unique, unordered collection)

  * Key name : QUERY\_SUBSCRIBERS:query\_id

  * Stores : IDs of all the users who have commented on that query atleast once.

  * Useful commands : SADD, SMEMBERS, SPOP

  * Write : Whenever somebody comments on a post, make an entry in this set

  * Read : After writing, read this set again and create notifications for all those IDs

### Every user will have two redis LISTS

  * DataType : List (ordered collection implemented as a linked list)

  * Key names : READ\_NOTIFS:user\_id, UNREAD\_NOTIFS:user\_id

  * Stores : Complete information about a notification in JSON format.

  * Useful commands : LPUSH, RPUSH, LLEN, LRANGE

  * Write : Write READ\_NOTIFS:<user_id> list whenever a user sees all his notifications.
            Write UNREAD\_NOTIFS:<user_id> list whenever any user makes comment on a post where this user also did

  * Read : Read READ\_NOTIFS:<user_id> using a special method only when user demands.
           Read UNREAD\_NOTIFS:<user_id> whenver user tries to see 'all notifications' page.
