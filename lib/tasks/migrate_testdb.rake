# Redefine db:test:prepare so that a migration is run, instead of an export/import
# of development database.

Rake::Task["db:test:prepare"].send :instance_variable_set, "@prerequisites", FileList[]
Rake::Task["db:test:prepare"].send :instance_variable_set, "@actions", []

namespace :db do
  namespace :test do
    task :prepare => %w(environment db:test:migrate_schema)

    desc 'Use the migrations to create the test database'
    task :migrate_schema => "db:test:migrate_purge" do |t|
      ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['test'])
      ActiveRecord::Schema.verbose = t.application.options.trace
      ActiveRecord::Migrator.migrate("db/migrate/")
    end

    desc 'Use the migrations to purge the test database (roll back to revision 0)'
    task :migrate_purge do |t|
      ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['test'])
      ActiveRecord::Schema.verbose = t.application.options.trace
      ActiveRecord::Migrator.migrate("db/migrate/", 0)
    end
  end
end 