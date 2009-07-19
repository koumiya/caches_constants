class MasterGenerator < ModelGenerator
  def initialize(runtime_args, runtime_options = {})
    runtime_args.push "name:string"
    runtime_args.push "label:string"
    runtime_args.push "sort_order:integer"
    super
  end

  def manifest
    record do |m|
      m.class_collisions class_path, class_name
      
      m.directory File.join('app/models', class_path)
      m.template 'model.rb', File.join('app/models', class_path, "#{file_name}.rb")
      unless options[:skip_fixture]
        if File.exist?("spec")
          m.directory File.join('spec/fixtures', class_path)
          m.template 'model:fixtures.yml', File.join('spec/fixtures', "#{table_name}.yml")
        else
          m.directory File.join('test/fixtures', class_path)
          m.template 'model:fixtures.yml', File.join('test/fixtures', "#{table_name}.yml")
        end
      end

      unless options[:skip_migration]
        m.migration_template 'model:migration.rb', 'db/migrate', :assigns => {
          :migration_name => "Create#{class_name.pluralize.gsub(/::/, '')}"
        }, :migration_file_name => "create_#{file_path.gsub(/\//, '_').pluralize}"
      end
    end
  end
end