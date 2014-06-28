require 'chef/knife'
require 'chef/goiardi/knife_helpers'

class Chef
  class Knife
    class GoiardiGelDelete < Chef::Knife
      deps do
	require 'json'
      end

      include Chef::Goiardi::Gel::KnifeHelpers
      
      banner "knife goiardi gel delete [id]"

      def run
	@rest = Chef::REST.new(Chef::Config[:chef_server_url])
	gel_id = name_args[0]

	if gel_id.nil?
	  show_usage
	  exit 1
	end

	gel = @rest.delete("events/#{gel_id}", {})
	gel = format_event(gel)
	output(gel)
      end
    end
  end
end
