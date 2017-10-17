node.reverse_merge!(
  scalaenv: {
    scalaenv_root: '/usr/local/scalaenv',
    scheme:        'git',
    versions:      [],
  },
  :'scala-build' => {
    build_envs: [],
  }
)

include_recipe 'scalaenv::install'
