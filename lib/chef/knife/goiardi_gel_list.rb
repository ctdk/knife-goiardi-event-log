require 'chef/knife'
require 'chef/goiardi/knife_helpers'

class Chef
  class Knife
    class GoiardiGelList < Chef::Knife
      banner "knife goiardi gel list [options]"

      include Chef::Goiardi::Gel::KnifeHelpers

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

      option :start_time,
        :long => '--starttime MM-DD-YYYY',
        :short => '-s MM-DD-YYYY',
        :required => false,
        :description => 'Find events logged at a time great than or equal to the date provided. If the -u option is provided unix timestamps can be given instead.'

      option :end_time,
        :long => '--endtime MM-DD-YYYY',
        :short => '-e MM-DD-YYYY',
        :required => false,
        :description => 'Find events logged at a time less than or equal to the date provided. If the -u option is provided unix timestamps can be given instead.'

      option :unix_timestamps,
        :long => '--unixtimestamps',
        :short => '-u',
        :required => false,
        :boolean => true,
        :description => 'Indicates start and end times are given as unix time stamps and not date formats.'

      option :object_type,
	:long => '--object-type N',
	:short => '-T N',
	:required => false,
	:description => 'Narrow search for logged events to this object type (node, role, environment, etc.)'

      option :object_name,
	:long => '--object-name N',
	:short => '-N N',
	:required => false,
	:description => 'Narrow search for logged events to objects with this name.'

      option :doer,
	:long => '--doer N',
	:short => '-D N',
	:required => false,
	:description => 'Narrow search for logged events to actions performed by the given user or client.'

      def run
	@rest = Chef::REST.new(Chef::Config[:chef_server_url])
	rows = config[:limit] || 15
	offset = config[:offset] || 0
        start_time, end_time = apply_time_args()
	list = @rest.get_rest(generate_query(rows, offset, start_time, end_time, config), false, {})
	list.map! do |l|
	  l["event"]["object_type"] = format_object_type(l["event"]["object_type"])
	  li = { :event => { :id => l["event"]["id"],
	    :action => l["event"]["action"],
	    :name => l["event"]["object_name"],
	    :type => l["event"]["object_type"],
	    :time => format_time(l["event"]["time"]) } }
	  if config[:doer]
	    actor_info = JSON.parse(l["event"]["actor_info"])
	    li[:event][:performed_by] = actor_info["username"]
	  end
	  li
	end
	output(list)
      end

      private

      def generate_query(rows, offset, start_time, end_time, options)
	  query = "events?limit=#{rows}&offset=#{offset}"
	  if start_time
	    query += "&from=#{start_time}"
	  end
	  if end_time
	    query += "&until=#{end_time}"
	  end
	  if options[:object_type]
	    query += "&object_type=#{options[:object_type]}"
	  end
	  if options[:object_name]
	    query += "&object_name=#{options[:object_name]}"
	  end
	  if options[:doer]
	    query += "&doer=#{options[:doer]}"
	  end
	  query
      end

    end
  end


end
