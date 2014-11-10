require 'chef/formatters/minimal'
require 'chef/formatters/coloredputter'

class Chef
  module Formatters
    class Nice < Formatters::Base

      cli_name(:nice)

      # Override parent class
      def initialize(out, err)
        super
        @output = Coloredputter.new(out, err)
        livedrive_title = "
=====================================================================
=====================================================================

     dP\"\"b8 88  88 888888 888888     88\"\"Yb 88   88 88b 88
    dP   `I 88  88 88__   88__       88__dP 88   88 88Yb88
    Yb      888888 88\"\"   88\"\"       88\"Yb  Y8   8P 88 Y88
     YboodP 88  88 888888 88         88  Yb `YbodP' 88  Y8

=====================================================================
=====================================================================
"
        puts livedrive_title
      end

      # Called at the very start of a Chef Run
      def run_start(version)
        puts "Starting Chef Client, version #{version}"
        @initial_time = Time.now.to_f
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
      end

      def converge_complete
        total_exec_time = Time.now.to_f - @initial_time
        puts "System converged in #{total_exec_time.round(2)}"
      end

      # Called when cookbook loading starts.
      def library_load_start(file_count)
        puts "Compilation"
      end

      def resource_action_start(resource, action, notification_type=nil, notifier=nil)
        if resource.cookbook_name && resource.recipe_name
          resource_recipe = "#{resource.cookbook_name}::#{resource.recipe_name}"
        else
          puts "#{resource.cookbook_name}::#{resource.recipe_name}"
          resource_recipe = "<wow, so much LWRP>"
        end

        if resource_recipe != @current_recipe
          if @recipe_start_time
            recipe_exec_time = Time.now.to_f - @recipe_start_time
            puts "(#{recipe_exec_time.round(3)} secs)"
          end
          puts "Recipe: #{resource_recipe}"
          @current_recipe = resource_recipe
          @recipe_start_time = Time.now.to_f
        end
        @resource_start_time = Time.now.to_f
      end

      # Called when a resource action has been skipped b/c of a conditional
      def resource_skipped(resource, action, conditional)
        # Output should be blue (Skipped)
        resource_exec_time = Time.now.to_f - @resource_start_time
        puts("  * #{resource} action #{action} (#{resource_exec_time.round(3)} secs)", 'blue')
      end

      # Called when a resource has no converge actions, e.g., it was already correct.
      def resource_up_to_date(resource, action)
        # Output should be green
        resource_exec_time = Time.now.to_f - @resource_start_time
        puts("  * #{resource} action #{action} (#{resource_exec_time.round(3)} secs)", 'green')
      end

      # Called after a resource has been completely converged.
      def resource_updated(resource, action)
        # Output should be yellow (changes are applied)
        resource_exec_time = Time.now.to_f - @resource_start_time
        puts("  * #{resource} action #{action} (#{resource_exec_time.round(3)} secs)", 'yellow')
      end
    end
  end
end