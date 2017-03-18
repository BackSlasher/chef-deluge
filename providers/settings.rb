use_inline_resources

action :set do
  new_resource.settings.each do |k,v|
    deluge_setting k do
      value v

      deluge_console new_resource.deluge_console
      deluge_config  new_resource.deluge_config
    end
  end
end
