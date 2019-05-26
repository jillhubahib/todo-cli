module Todo
  require_relative 'task'

  class Manager
    def initialize(options = {})
      @options, @tasks = options, Task.all

      db_connect
    end

    def add(todo)
      task = Task.create(name: todo)
      task.name
    end

    def clear!
      Task.destroy_all
    end

    def delete(todo)
      if task = Task.find_by(id: todo)
        task.destroy
        task.name
      end
    end

    def done(todo)
      if task = Task.find_by(id: todo)
        task.update(completed_at: Time.current)
        task.name
      end
    end

    def list
      filtered_tasks.each do |task|
        puts "#{task.id} - #{task.name}"
      end
    end

    private

    def app_root
      @app_root ||= File.expand_path('../../..', __FILE__)
    end

    def db_connect
      config = db_configuration
      config["database"] = "#{app_root}/#{config['database']}"

      ActiveRecord::Base.establish_connection(config)

      unless ::Todo::Task.table_exists?
        puts "Required table is not setup!"
        exit
      end
    end

    def db_configuration
      db_configuration_file = File.join(app_root, 'db', 'config.yml')
      YAML.load(File.read(db_configuration_file))[env]
    end

    def env
      @env ||= ENV['RAILS_ENV'].nil? || ENV['RAILS_ENV'].empty? ? 'production' : ENV['RAILS_ENV']
    end

    def filtered_tasks
      if @options[:filter] && Task.respond_to?(@options[:filter])
        @tasks.send(@options[:filter])
      else
        @tasks.active
      end
    end
  end
end
