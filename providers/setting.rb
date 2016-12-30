use_inline_resources

def get_config(resource)
  res = shell_out!(resource.deluge_console, '-c', resource.deluge_config, 'config', resource.setting)
  res.stdout
end

def set_config(resource)
  shell_out!(resource.deluge_console, '-c', resource.deluge_config, 'config', '--set', resource.setting, resource.value)
end

action :set do
  if get_config(new_resource) != new_resource.value then
    set_config(new_resource)
    new_resource.updated_by_last_action(true)
  else
    new_resource.updated_by_last_action(false)
  end
end
