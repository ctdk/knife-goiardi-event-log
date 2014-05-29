require 'chef/knife'
require 'chef/goiardi/knife_helpers'

class Chef
  class Knife
    class GoiardiGelList < Chef::Knife
      banner "knife goiardi gel list [options]"

      include Chef::Goiardi::KnifeHelpers

      option :limit,
	:long => '--limit N',
	:short => '-l N',
	:required => false,
	:description => "Specifies number of events to be returned. Default is 15."

      option :offset,
	:long => '--offset N',
	:short => '-O N',
	:required => false,
	:description => "Offset to fetch events from. Default is 0."

      def run
	@rest = Chef::REST.new(Chef::Config[:chef_server_url])
	rows = config[:limit] || 15
	offset = config[:offset] || 0
	list = @rest.get_rest("events?limit=#{rows}&offset=#{offset}", false, {})
	list.map! do |l|
	  l["event"]["object_type"] = format_object_type(l["event"]["object_type"])
	  { :event => { :id => l["event"]["id"],
	    :action => l["event"]["action"],
	    :name => l["event"]["object_name"],
	    :type => l["event"]["object_type"],
	    :time => format_time(l["event"]["time"]) } }
	end
	output(list)
      end

    end
  end


end
