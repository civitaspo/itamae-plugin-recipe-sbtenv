node.reverse_merge!(
  sbtenv: {
    scheme:   'git',
    user:     ENV['USER'],
    versions: [],
  },
  :'sbt-build' => {
    build_envs: [],
  }
)

unless node[:sbtenv][:sbtenv_root]
  case node[:platform]
  when 'osx', 'darwin'
    user_dir = '/Users'
  else
    user_dir = '/home'
  end
  node[:sbtenv][:sbtenv_root] = File.join(user_dir, node[:sbtenv][:user], '.sbtenv')
end

include_recipe 'sbtenv::install'
