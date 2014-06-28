class Chef
  module Goiardi
    module Gel
      module KnifeHelpers
	def format_object_type(obj)
	  if obj == "*cookbook.CookbookVersion"
	    "cookbook_version"
	  else
	    obj =~ /^\*?(\w+)\.?/
	    $1 || obj
	  end
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

	# Code below adapted from the knife-reporting plugin
	def apply_time_args()
	  if config[:start_time]
	    start_time = convert_to_unix_timestamps(config[:start_time])
	  else
	    start_time = nil
	  end

	  if config[:end_time]
	    end_time = convert_to_unix_timestamps(config[:end_time])
	  else
	    end_time = nil
	  end


	  return start_time, end_time
	end


	def convert_to_unix_timestamps(time_to_change)
	  if config[:unix_timestamps]
	    new_time = time_to_change.to_i
	  else
	    # Take user supplied input, assumes it is in a valid date format,
	    # convert to a date object to ensure we have the proper date format for
	    # passing to the time object (but converting is not a validation step,
	    # so bad user input will still be bad)
	    # then convert to a time object, and then convert to a unix timestamp
	    # An error could potentially be thrown if the conversions don't work
	    # This does work on windows - to_i on time even on windows still returns a unix timestamp
	    # Verified on ruby 1.9.3 on a windows 2000 ami on aws
	    new_time = Time.parse(Date.strptime(time_to_change, '%m-%d-%Y').to_s).to_i
	  end

	  return new_time
	end
      end
    end
  end
end
