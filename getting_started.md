# Sourcecode Documentation

---

## Set everything up
* clone the repo
```bash
git clone https://github.com/virtapi/virtapi.git
```

* install dependencies
```bash
gem install bundler
cd virtapi
bundle install
```

* setup the database (Todo: use rake tasks)
```bash
for i in database/migrations/*.rb; do ruby $i up; done
```

* Import seed data (data that is needed to run the app)
```bash
bundle exec rake db:seed
[much output....]
```

* start the webserver
```bash
$ bundle exec puma -C puma.rb
[14365] Puma starting in cluster mode...
[14365] * Version 2.15.3 (ruby 2.3.0-p0), codename: Autumn Arbor Airbrush
[14365] * Min threads: 0, max threads: 1
[14365] * Environment: development
[14365] * Process workers: 1
[14365] * Phased restart available
[14365] * Listening on tcp://127.0.0.1:4567
[14365] Use Ctrl-C to stop
[14365] - Worker 0 (pid: 14367) booted, phase: 0
```

* List all available Rake tasks
```
$ bundle exec rake -T
rake db:create              # Creates the database from DATABASE_URL or config/database.yml for the current RAILS_ENV (use db:create:all to create all databases in the config)
rake db:drop                # Drops the database from DATABASE_URL or config/database.yml for the current RAILS_ENV (use db:drop:all to drop all databases in the config)
rake db:fixtures:load       # Load fixtures into the current environment's database
rake db:migrate             # Migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)
rake db:migrate:status      # Display status of migrations
rake db:rollback            # Rolls the schema back to the previous version (specify steps w/ STEP=n)
rake db:schema:cache:clear  # Clear a db/schema_cache.dump file
rake db:schema:cache:dump   # Create a db/schema_cache.dump file
rake db:schema:dump         # Create a db/schema.rb file that is portable against any DB supported by AR
rake db:schema:load         # Load a schema.rb file into the database
rake db:seed                # Load the seed data from db/seeds.rb
rake db:setup               # Create the database, load the schema, and initialize with the seed data (use db:reset to also drop the database first)
rake db:structure:dump      # Dump the database structure to db/structure.sql
rake db:structure:load      # Recreate the databases from the structure.sql file
rake db:version             # Retrieves the current schema version number
```
