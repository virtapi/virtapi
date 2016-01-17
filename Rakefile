require 'yaml'
require 'logger'
require 'active_record'
require 'rubocop/rake_task'
require 'haml_lint/rake_task'
require 'yamllint/rake_task'

# configure ActiveRecord Tasks
include ActiveRecord::Tasks

class Seeder
  def initialize(seed_file)
    @seed_file = seed_file
  end

  def load_seed
    fail "Seed file '#{@seed_file}' does not exist" unless File.file?(@seed_file)
    load @seed_file
  end
end

root = File.expand_path '..', __FILE__
DatabaseTasks.env = ENV['ENV'] || 'development'
DatabaseTasks.database_configuration = YAML.load(File.read(File.join(root, 'config/database.yml')))
DatabaseTasks.db_dir = File.join root, 'database'
DatabaseTasks.fixtures_path = File.join root, 'test/fixtures'
DatabaseTasks.migrations_paths = [File.join(root, 'database/migrations')]
DatabaseTasks.seed_loader = Seeder.new File.join root, 'database/seeds.rb'
DatabaseTasks.root = root

task :environment do
  ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
  ActiveRecord::Base.establish_connection DatabaseTasks.env.to_sym
end

load 'active_record/railties/databases.rake'

# configure RuboCop Tasks
RuboCop::RakeTask.new

# configure Haml Linter
HamlLint::RakeTask.new do |t|
  t.files = ['views/*.haml']
end

# configure YAML Linter
YamlLint::RakeTask.new do |t|
  t.paths = ['config/*.yml']
end

# create a custom Task that loops through all tests
desc 'Run RuboCop and Haml-Linter'
task test: [:rubocop, :haml_lint, :yamllint]
