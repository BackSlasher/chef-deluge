actions :create, :delete
default_action :create

attribute :local_password, required: true
attribute :users, kind_of: Hash, default: {}
attribute :auth_file, kind_of: String, name_attribute: true
