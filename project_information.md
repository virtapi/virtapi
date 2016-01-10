# Information about the project process

## Contents
+ [Implementation](#implementation)
+ [Usage](#usage)
    - [Clone the Repo](#clone-the-repo)
    - [Install Dependencies](#install-dependencies)
    - [Setup the Database](#setup-the-database)
    - [Import seed data](#import-seed-data)
    - [Start the Webserver](#start-the-webserver)
    - [List all available Rake Tasks](#list-all-available-rake-tasks)
+ [Projectmanagement](#projectmanagement)
+ [Software Details](#software-details)
    - [Concept](#concept)
    - [Models](#models)
    - [Puma](#puma)
    - [ActiveRecord](#activerecord)
+ [Current State](#current-state)
+   - [Costs and stats](#costs-and-stats)

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

## Software Details
### Concept
The MVC paradigm is very common in nowadays software projects and considered as state of the art so we want to use it as well. Our current implemention only support JSON output of our objects (as descriped in the API documentation) and JSON encoded input (as a Restful API is supposed to) so we do not have any views. All [Models](https://github.com/virtapi/virtapi/tree/dev-sinatra/sources/models) are child classes from ActiveRecord::Base, this allows us an easy mapping from objects to any relational database. Every [controller](https://github.com/virtapi/virtapi/tree/dev-sinatra/sources/controllers) is named after a model, they provide a sinatra namespace also named after the model and host the basic CRUD operations (Create Read Update Delete).

### Models
Thanks to ActiveRecord our models can be very short:
```ruby
class CacheOption < ActiveRecord::Base
end
```
The above example is our complete and working model for CaheOption. Some models are a bit more complex if they have relations to others:
```ruby
class Domain < ActiveRecord::Base

  has_many :interfaces
  has_many :ipv4s, through: :interfaces
  has_many :ipv6s, through: :interfaces
  has_many :vlans, through: :interfaces
  has_many :storages
  has_one :domain_state

  belongs_to :node_method
end
```
Our Domain model has 0 to N interfaces, every Interface has 0 to N Ipv4, Ipv6 and Vlans, so also a Domain owns them through an Interface. We do not need to specify these indirect relations, but it helps ActiveRecord to cache data als also provides useful functions like:
```ruby
domain = Domain.find(1)
domain.ipv4.all
```

Without this notation you have to do (which is considered as bad practice):
```ruby
domain = Domain.find(1)
domain.interface.all.ipv4.all
```

### Puma
Puma is an awesome, in Ruby written, webserver. It needs just a very tiny configuration:
```ruby
pidfile 'puma.pid'
threads 0,1
workers 1
#daemonize true
bind 'tcp://127.0.0.1:4567'
```

This will start Puma with one worker with one thread. You need root priviledges if you want him to bind at ports below 1024 (well known port range).

### ActiveRecord
ActiveRecord offer so many cool features, we will take a look at a few of them. It supports several database backends, we use sqlite and postgres in our case, first one for testing and development, the latter one for the production usage. Both RDBMS have huge differences, but ActiveRecord abstracts them nicely and also provides migrations. A migration is an operation which modofies the database, for example adding a colum or dropping it. A migration can be run on any databasebackend that ActiveRecord supports.
```ruby
require '../../sources/virtapi_app.rb'

class InitializeNodeTable < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.timestamps null: false
      t.belongs_to :node_state, index: true
      t.string :fqdn
      t.string :location
    end

    create_table :node_states do |t|
      t.timestamps null: false
      t.string :name
      t.string :description
    end
  end
end

InitializeNodeTable.migrate(ARGV[0])
```

This is our migration for setting up the Node Model related stuff. This Migration can be used to add the tables but also to remove them. ActiveRecord will automatically add the attributes to our model.

We also own a seeds.rb, this file contains seed data (data that is needed in the database to actually use the app):
```ruby
require "#{__dir__}/../sources/virtapi_app.rb"

# Create all Cache Options for storage
cache_options = [
  ['default', 'the hypervisor default'],
  ['none', 'nobody knows'],
  ['writethrough', 'do not use the cache'],
  ['writeback', 'use the cache'],
  ['directsync' 'even ignore page cache'],
  ['unsafe', 'cache allll the things, ignore sync() requests']
]
cache_options.each do |option|
  CacheOption.create(name: option[0], description: option[1])
end
# create storage types
# wat?

# create virtualization methods
methods = [
  'KVM',
  'Qemu',
  'Docker',
  'Parallels Cloud Server',
  'Parallels Server Bare Metall',
  'systemd-nspawn'
]
methods.each do |method|
  VirtMethod.create(name: method)
end

# create all node states
state_list = [
  ['stopped', 'node is stopped'],
  ['running', 'node is running'],
  ['deactivated', 'someone disabled this node'],
  ['maintenance' 'there is currently maintenance going on']
]
state_list.each do |state|
  NodeState.create(name: state[0], description: state[1])
end

# create all domain states
state_list = [
  ['stopped', 'domain is stopped'],
  ['running', 'domain is running'],
  ['deactivated', 'an admin disabled this domain'],
  ['maintenance' 'there is currently maintenance on the host system, keep calm']
]
state_list.each do |state|
  DomainState.create(name: state[0], description: state[1])
end

# create all vlans
(0..4095).each do |id|
  Vlan.create(tag: id)
end
```

This adds data to all the relevant tables, also we autogenerate the vlans. This can be done via one of our Rake tasks:
```ruby
bundle exec rake db:seed
```

---

## Current State
This project started in the sommer of 2014, right now (december 2015) we have got a working solution of our API which provides JSON output of our objects and accepts JSON as the input content type. Right now we don't support HTML/MSGPACK content type, we will add this feature in the next version. We're also provding an API documention for users at the end. The models were a bit modified, in the original version, the interface model was only related to virtual machines. This behavior got changed and now nodes are also related to it and do not store their IP configuration in their model.

### Costs and stats
This project is completly created and mantained by volunteers so there are no costs for employees. We have got detailed statistics about [the contributions](https://github.com/virtapi/virtapi/graphs/contributors), their relation to [working days](https://github.com/virtapi/virtapi/graphs/commit-activity) and also a [punch card](https://github.com/virtapi/virtapi/graphs/punch-card) which shows the correlation between all days of the week and the contribution across the complete project.
