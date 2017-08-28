# Regardless which environment you are on, make sure that you use Postgres as your database on your development 
# environment, because 1) Postgres is currently the best open-source SQL databases on the market and 
# 2) we are going to deploy to Heroku, which uses Postgres as the database. It's always a good idea to keep
# your local development database the same as your database on production.

# Regardless which environment you are on, make sure that you use Postgres as your database on your development 
# environment, because 1) Postgres is currently the best open-source SQL databases on the market and 
# 2) we are going to deploy to Heroku, which uses Postgres as the database. It's always a good idea to keep
# your local development database the same as your database on production.

# 2. Run `sudo service postgresql start` in the command line. Then it should be up and running. You can test it in rails console.

# Also, if you're getting an error on running bundle install saying something like "you are using Ruby version 2.1.5 but you have version 2.1.1 listed", try rvm use "2.1.1" in the command line.
development:
  adapter: postgresql
  encoding: unicode
  database: myflix_development
  pool: 5
  username: ubuntu
  password:

test:
  adapter: postgresql
  encoding: unicode
  database: myflix_test
  pool: 5
  username: ubuntu
  password:
  
It appears that above setting still leads to error: FATAL: role "ubuntu" does not exist

Therefore following steps are to fix this error:

1. start the database with command sudo service postgresql start 
2. log into postgres: sudo -u postgres psql
3. In the postgres, postgres=# CREATE ROLE ubuntu WITH LOGIN PASSWORD 'password';
4. In database.yml file, since the database name is mentioned as myflix_development
   postgres=# CREATE DATABASE myflix_development OWNER ubuntu; `\q` to out
5. run `rake db:migrate`
6. repeat step4 for "test", then run `rake db:migrate RAILS_ENV=test`

Therefore the database.yml should look like this:
development: 
adapter: postgresql 
encoding: unicode 
database: myflix_development 
host: localhost 
pool: 5 
username: ubuntu 
password: password 
