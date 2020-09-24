actions :set
default_action :set

attribute :settings, kind_of: Hash, default: {}
attribute :deluge_config, kind_of: String, required: true
