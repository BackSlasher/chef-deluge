use_inline_resources

def get_script_path
    cookbook = run_context.cookbook_collection['deluge']
    python_file = cookbook.preferred_filename_on_disk_location(run_context.node, :files, "setter.py")
    return python_file
end


def set_settings(settings, config_dir)
    script_file = get_script_path
    output = shell_out!("python", script_file, env: {
        "DELUGE_CONFIG_PATH" => config_dir,
        "DELUGE_SETTINGS" => settings.to_json,
    })
    lines = output.stdout.split("\n")
    has_changes = lines.map{|s|s[/^Changes: (\w+)$/, 1]}.filter{|s|s!=nil}.map{|s|s.downcase=="true"}.first
    return has_changes
end

action :set do
  has_changes = set_settings(
    new_resource.settings,
    new_resource.deluge_config
  )
  new_resource.updated_by_last_action(has_changes)
end
