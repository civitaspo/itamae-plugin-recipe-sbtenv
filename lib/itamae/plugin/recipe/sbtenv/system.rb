node.reverse_merge!(
  sbtenv: {
    sbtenv_root: '/usr/local/sbtenv',
    scheme:      'git',
    versions:    [],
  },
  :'sbt-build' => {
    build_envs: [],
  }
)

include_recipe 'sbtenv::install'
