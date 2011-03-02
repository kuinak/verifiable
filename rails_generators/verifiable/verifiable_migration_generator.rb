class VerifiableMigrationGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template 'verifiable_migration.rb', 'db/migrate', :migration_file_name => "verifiable_migration"
    end
  end
end