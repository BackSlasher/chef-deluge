use_inline_resources

def def_stuff(resource, action)
  template resource.name do
    source 'default_file.erb'
    variables ({
      user: new_resource.user,
      mask: new_resource.mask,
      config_dir: new_resource.config_dir,
      log_location: new_resource.log_location,
      log_level: new_resource.log_level,
    })
  end
end

action :create do
  def_stuff(new_resource, :create)
end

action :delete do
  def_stuff(new_resource, :delete)
end
