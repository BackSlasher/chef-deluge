actions :set
default_action :set

attribute :settings, kind_of: Hash, default: {}
attribute :deluge_console, kind_of: String, default: 'deluge-console' # '/usr/bin/deluge-console'
attribute :deluge_config, kind_of: String, required: true
