require 'chef/knife'
require 'chef/goiardi/knife_helpers'

class Chef
  class Knife
    class GoiardiGelPurge < Chef::Knife
      deps do
	require 'json'
      end

      include Chef::Goiardi::KnifeHelpers
      
      banner "knife goiardi gel purge [id]"

      def run
	@rest = Chef::REST.new(Chef::Config[:chef_server_url])
	gel_id = name_args[0]

	if gel_id.nil?
	  show_usage
	  exit 1
	end

	gel = @rest.delete("events?purge=#{gel_id}", {})
	output(gel)
      end
    end
  end
end
