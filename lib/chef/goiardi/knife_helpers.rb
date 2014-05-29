class Chef
  module Goiardi
    module KnifeHelpers
      def format_object_type(obj)
	obj =~ /^\*?(\w+)\.?/
	$1 || obj
      end
      def format_time(timestamp)
	Time.parse(timestamp).strftime("%c")
      end
      def format_event(gel)
	gel["object_type"] = format_object_type(gel["object_type"])
	gel["actor_info"] = JSON.parse(gel["actor_info"])
	gel["extended_info"] = JSON.parse(gel["extended_info"])
	gel["time"] = format_time(gel["time"])
	gel
      end
    end
  end
end
