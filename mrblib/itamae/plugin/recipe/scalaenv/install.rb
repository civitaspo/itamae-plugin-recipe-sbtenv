# This recipe requires `scalaenv_root` is defined.

include_recipe 'scalaenv::dependency'

# TODO: configure the scalaenv repo url?
# repo_host = nodo[:scalaenv][:scalaenv_repo_host] || 'github.com'
# repo_org  = node[:scalaenv][:scalaenv_repo_org]  || 'scalaenv'
scheme        = node[:scalaenv][:scheme]
scalaenv_root = node[:scalaenv][:scalaenv_root]

git scalaenv_root do
  repository "#{scheme}://github.com/scalaenv/scalaenv.git"
  revision   node[:scalaenv][:revision] if node[:scalaenv][:revision]
  user       node[:scalaenv][:user]     if node[:scalaenv][:user]
end

directory File.join(scalaenv_root, 'plugins') do
  user node[:scalaenv][:user] if node[:scalaenv][:user]
end

# TODO: if some scalaenv plugins are released, pubilsh this.
# ex)
#   scalaenv_plugin:
#     - github.com/civitaspo/scalaenv-default-packages
#
# define :scalaenv_plugin do
#   repo_url = "#{scheme}://#{params[:name]}.git"
#   pkg      = params[:name].split('/').last
# 
#   git "#{scalaenv_root}/plugins/#{pkg}" do
#     repository repo_url
#     revision   node[name][:rdevision] if node[name][:revision]
#     user       node[:scalaenv][:user] if node[:scalaenv][:user]
#   end
# end

scalaenv_init = <<-EOS
  export SCALAENV_ROOT=#{scalaenv_root}
  export PATH="#{scalaenv_root}/bin:${PATH}"
  eval "$(scalaenv init -)"
EOS

# nodoc
build_envs = node[:'scala-build'][:build_envs].map do |key, value|
  %Q[export #{key}="#{value}"\n]
end.join

node[:scalaenv][:versions].each do |version|
  execute "scalaenv install #{version}" do
    command "#{scalaenv_init} #{build_envs} scalaenv install #{version}"
    not_if  "#{scalaenv_init} scalaenv versions | grep #{version}"
    user    node[:scalaenv][:user] if node[:scalaenv][:user]
  end
end

if node[:scalaenv][:global]
  node[:scalaenv][:global].tap do |version|
    execute "scalaenv global #{version}" do
      command "#{scalaenv_init} scalaenv global #{version}"
      not_if  "#{scalaenv_init} scalaenv version | grep #{version}"
      user    node[:scalaenv][:user] if node[:scalaenv][:user]
    end
  end
end
