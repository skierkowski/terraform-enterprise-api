require 'yaml'
require 'colorize'

require 'terraform-enterprise-client'

module TerraformEnterprise
  module Commands
    class Command < Thor
      class_option :color, type: :boolean, default: true

      no_commands do
        def render(obj, render_options={})
          String.disable_colorization = !options['color']

          if obj.is_a?(TerraformEnterprise::API::Response)
            if obj.code == 200
              puts "Success".green
              puts obj.data.to_yaml
            elsif
              if obj.body['errors']
                obj.body['errors'].each do |error|
                  puts "Error (#{error['status']}): #{error['title']}".red
                end
              else
              end
            end
          else
            puts obj.to_yaml
          end
        end

        def client
          settings           = { }
          settings[:api_key] = options[:token] || ENV['TERRAFORM_ENTERPRISE_TOKEN']
          settings[:host]    = options[:host] if options[:host]
          TerraformEnterprise::Client.new(settings)
        end
      end
    end
  end
end