actions :set
default_action :set

attribute :setting, kind_of: String, name_attribute: true
attribute :value, kind_of: String, required: true
attribute :deluge_console, kind_of: String, default: 'deluge-console' # '/usr/bin/deluge-console'
attribute :deluge_config, kind_of: String, required: true
