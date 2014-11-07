require 'chef/formatters/minimal'

class Chef
  module Formatters
    class Nice < Formatters::Base

      cli_name(:nice)

      # Override parent class
      def initialize(out, err)
        super
        livedrive_title = "
888      d8b                   8888888b.          d8b
888      Y8P                   888   Y88b         Y8P
888                            888    888
888      888 888  888  .d88b.  888    888 888d888 888 888  888  .d88b.
888      888 888  888 d8P  Y8b 888    888 888P    888 888  888 d8P  Y8b
888      888 Y88  88P 88888888 888    888 888     888 Y88  88P 88888888
888      888  Y8bd8P  Y8b.     888  .d88P 888     888  Y8bd8P  Y8b.
88888888 888   Y88P     Y8888  8888888P   888     888   Y88P     Y8888
"
        puts livedrive_title
      end

      # Called at the very start of a Chef Run
      def run_start(version)
        puts "Starting Chef Client, version #{version}"
      end

      # Called before the cookbook collection is fetched from the server.
      def cookbook_resolution_start(expanded_run_list)
        puts "Very run list: #{expanded_run_list.inspect}"
      end

      def cookbook_sync_start(cookbook_count)
        puts "Cookbook synchronization"
      end

      # Called when cookbook +cookbook_name+ has been sync'd
      def synchronized_cookbook(cookbook_name)
        puts "  - #{cookbook_name}"
      end

      # Called after all cookbooks have been sync'd.
      def cookbook_sync_complete
        puts "Finish cookbook synchronization"
      end

      def converge_start(run_context)
        puts "Converge #{run_context.resource_collection.all_resources.size} resources"
        @recipe_start_time = 0
      end

      def converge_complete
        puts 'System converged'
      end

      # Called when cookbook loading starts.
      def library_load_start(file_count)
        puts "Compilation"
      end

      def resource_action_start(resource, action, notification_type=nil, notifier=nil)
        if resource.cookbook_name && resource.recipe_name
          resource_recipe = "#{resource.cookbook_name}::#{resource.recipe_name}"
        else
          resource_recipe = "<wow, so much LWRP>"
        end

        if resource_recipe != @current_recipe
          puts "Recipe: #{resource_recipe}"
          @current_recipe = resource_recipe
          @recipe_start_time = Time.now.to_f
        end
        if @resource_start_time
          resource_exec_time = Time.now.to_f - @resource_start_time
        else
          resource_exec_time = 0
        end
        puts "  * #{resource} action #{action} (#{resource_exec_time.round(3)} secs)"
        @resource_start_time = Time.now.to_f
      end
    end
  end
end