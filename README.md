# Knife Goiardi Event Log (gel)

A knife plugin for viewing goiardi's event log. This plugin only works with a
goiardi server, not the official chef server.

## Usage

There are four goiardi event log commands: `knife goiardi gel list`, `knife
goiardi gel show`, `knife goiardi gel delete` and `knife goiardi gel purge`.

`knife goiardi gel list` returns a list of logged events. A limit may be 
specified with `--limit`; the default limit is 15. An offset may also be specified; the default offset is 0.

Results may be further narrowed using the `--starttime`, `--endtime`, `--doer`,
`--object-type`, and `--object-name` options. The time options narrow the 
results by date range, the `--doer` option searches for events done by the named
user, and `--object-type` and `--object-name` limit the search to objects of the
given type and name respectively. NB: these options only work with goiardi 0.6.0
and above. Earlier versions that support event logging will ignore them.

`knife goiardi gel show [id]` gives a detailed listing of a particular event log
item.

`knife goiardi gel delete [id]` deletes the given event, and prints out a 
detailed display of the deleted event.

`knife goiardi gel purge [id]` purges all event log items with an id less than
the given id. After purging the events, it displays the number of events that
were purged.

## Installation

The best way to install this plugin is with gem:

    $ gem install knife-goiardi-event-log

The steps at http://docs.opscode.com/plugin_knife_custom.html#install-a-plugin 
also work.

## License

Copyright 2014, Jeremy Bingham (<jbingham@gmail.com>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

This plugin also contains code from the Chef knife-reporting plugin, available
under the terms of the Apache 2.0 license:

Copyright 2013-2014, Chef 

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
