node.reverse_merge!(
  scalaenv: {
    scheme:   'git',
    user:     ENV['USER'],
    versions: [],
  },
  :'scala-build' => {
    build_envs: [],
  }
)

unless node[:scalaenv][:scalaenv_root]
  case node[:platform]
  when 'osx', 'darwin'
    user_dir = '/Users'
  else
    user_dir = '/home'
  end
  node[:scalaenv][:scalaenv_root] = File.join(user_dir, node[:scalaenv][:user], '.scalaenv')
end

include_recipe 'scalaenv::install'
