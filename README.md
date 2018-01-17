# How does this work?

This Dockerfile and docker-compose file will refresh data from a remote Postgres server/db to a local running postgres container.

## What does it do?

It launches a postgres container and persists the postgres data at ``/Users/username/pgdata`` on your local machine.  By default, the postgres user is ``pg`` , the postgres db is called ``pg`` and the postgres user password is ``password``.

In addition to launching a postgres container, it also launches a ruby container with pgsync installed.  Pgsync then pulls prod data from the remote Postgres instance and dumps the data into your locally running postgres container.



## Edits that need to be made by you:

1) Edit the ``docker-compose.yml`` file.  Edit ``username`` on line 9 and add your local username on your Mac.


## Basic usage

``docker-compose up``

This will bring up the two containers.  If everything goes well, you will start to see pgsync logs.  It will take 60 seconds before pgsync starts - this gives enough time to allow the postgres container services to fully startup.

## Other usage

After syncing, if you want to check out the db using a PG client (like Postico or PgAdmin), run this in docker (be sure to substitute username for you local username):

```
docker run -d --name="postgres" \
-v /Users/username/pgdata:/var/lib/postgresql/data \
-p 5432:5432 \
-e POSTGRES_USER='pg' \
-e POSTGRES_PASSWORD='password' \
postgres
```

This should launch a postgres container with your sync'd data.  It will be available at ``localhost:5432``.  Connect with preferrend PG client using username ``pg`` and password ``password``

## Gotchas

If you launch the Postgres docker container and choose to expose port ``5432`` on your Mac (ie. ``-p 5432:5432``) you need to make sure you don't have a local Postgres service running on your Mac.  If you do, you're gonna have a bad time.  Make sure to stop any local running Postgres instance on your Mac.  To check, open up Activity Monitor on your Mac and search ``postgres`` to see if any processes are running.

How to stop a local running Postgres service?

``brew services stop postgresql``

or

``pg_ctl -D /usr/local/var/postgres stop``

Then launch your Postgres Docker container and hookup your PG client to it.


## TODO

Add environment variables for flexibility.