use_inline_resources

def def_stuff(resource, action)
  template resource.name do
    source 'auth.erb'
    variables ({
      local_password: resource.local_password,
      users: resource.users,
    })
  end
end

action :create do
  def_stuff(new_resource, :create)
end

action :delete do
  def_stuff(new_resource, :delete)
end
