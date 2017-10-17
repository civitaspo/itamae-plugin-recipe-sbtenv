# This recipe requires `sbtenv_root` is defined.

include_recipe 'sbtenv::dependency'

# TODO: configure the sbtenv repo url?
# repo_host = nodo[:sbtenv][:sbtenv_repo_host] || 'github.com'
# repo_org  = node[:sbtenv][:sbtenv_repo_org]  || 'sbtenv'
scheme      = node[:sbtenv][:scheme]
sbtenv_root = node[:sbtenv][:sbtenv_root]

git sbtenv_root do
  repository "#{scheme}://github.com/sbtenv/sbtenv.git"
  revision   node[:sbtenv][:revision] if node[:sbtenv][:revision]
  user       node[:sbtenv][:user]     if node[:sbtenv][:user]
end

directory File.join(sbtenv_root, 'plugins') do
  user node[:sbtenv][:user] if node[:sbtenv][:user]
end

# TODO: if some sbtenv plugins are released, pubilsh this.
# ex)
#   sbtenv_plugin:
#     - github.com/civitaspo/sbtenv-default-packages
#
# define :sbtenv_plugin do
#   repo_url = "#{scheme}://#{params[:name]}.git"
#   pkg      = params[:name].split('/').last
# 
#   git "#{sbtenv_root}/plugins/#{pkg}" do
#     repository repo_url
#     revision   node[name][:rdevision] if node[name][:revision]
#     user       node[:sbtenv][:user] if node[:sbtenv][:user]
#   end
# end

sbtenv_init = <<-EOS
  export SBTENV_ROOT=#{sbtenv_root}
  export PATH="#{sbtenv_root}/bin:${PATH}"
  eval "$(sbtenv init -)"
EOS

# nodoc
build_envs = node[:'sbt-build'][:build_envs].map do |key, value|
  %Q[export #{key}="#{value}"\n]
end.join

node[:sbtenv][:versions].each do |version|
  execute "sbtenv install #{version}" do
    command "#{sbtenv_init} #{build_envs} sbtenv install #{version}"
    not_if  "#{sbtenv_init} sbtenv versions | grep #{version}"
    user    node[:sbtenv][:user] if node[:sbtenv][:user]
  end
end

if node[:sbtenv][:global]
  node[:sbtenv][:global].tap do |version|
    execute "sbtenv global #{version}" do
      command "#{sbtenv_init} sbtenv global #{version}"
      not_if  "#{sbtenv_init} sbtenv version | grep #{version}"
      user    node[:sbtenv][:user] if node[:sbtenv][:user]
    end
  end
end
