\newpage

# Information about the project process

## Contents
+ [Implementation](#implementation)
  - [Sinatra](#sinatra)
  - [sqlite3](#sqlite3)
  - [activerecord](#activerecord)
  - [puma](#puma)
  - [Rake](#rake)
  - [Bundler](#bundler)
+ [Usage](#usage)
  - [Clone the Repo](#clone-the-repo)
  - [Install Dependencies](#install-dependencies)
  -	[Setup the Database](#setup-the-database)
  -	[Import seed data](#import-seed-data)
  -	[Start the Webserver](#start-the-webserver)
  -	[List all available Rake Tasks](#list-all-available-rake-tasks)
+	[Projectmanagement](#projectmangement)
+ [Current State](#current-state)

---

## Implementation
This will be implemented in Ruby because this suits all our needs described in the [requirements](#requirements), there is also a bit of Ruby knowledge already present in the team. We are using the following gems:
+ [Sinatra](http://www.sinatrarb.com/intro.html) - Sinatra is a DSL for quickly creating web applications in Ruby with minimal effort
+ [sqlite3](https://github.com/sparklemotion/sqlite3-ruby) - Allows us to use [sqlite databases](https://www.sqlite.org/about.html) for testing and development
+ [activerecord](http://guides.rubyonrails.org/active_record_basics.html) - Ruby implementation of the [active record software development](https://en.wikipedia.org/wiki/Active_record_pattern) daradigm (maps objects from the MVC pattern into relational databases)
+ [puma](http://puma.io/) - Puma is a small library that provides a very fast and concurrent HTTP 1.1 server for Ruby web applications
+ [Rake](https://github.com/ruby/rake#description) - This is a Make-like DSL for running jobs. We use it for tests and database migrations
+ [Bundler](http://bundler.io/) - Gem for managing all project related gems in every environment (testing/production) via a [Gemfile](https://github.com/virtapi/virtapi/blob/dev-sinatra/Gemfile)

---

## Usage
### Clone the repo
```bash
git clone https://github.com/virtapi/virtapi.git
```

### Install Dependencies
```bash
gem install bundler
cd virtapi
bundle install
```

### Setup the Database
```bash
cd sources
for i in databases/migrations/*.rb; do ruby $i up; done
```

### Import Seed Data
(data that is needed to run the app, from our seed [file](https://github.com/virtapi/virtapi/blob/dev-sinatra/database/seeds.rb))
```bash
bundle exec rake db:seed
[much output....]
```

### start the webserver
```bash
$ puma -C puma.rb
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

### List all available Rake tasks
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

---

## Projectmanagement
We are using Kanban as our development modell, [Waffle](https://waffle.io/) provides a free Kanban Board which links against our [github issues](https://github.com/virtapi/virtapi/issues). Besides our Backlog where we tracked all open tasks we also had the stages "in discussion", "development", "testing" and "done".

---

## Current State
This project started in the sommer of 2014, right now (december 2015) we have got a working solution of our API which provides JSON output of our objects and accepts JSON as the input content type. Right now we don't support HTML/MSGPACK content type, we will add this feature in the next version. We're also provding an API documention for users at the end.
