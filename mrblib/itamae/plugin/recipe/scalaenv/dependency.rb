# TODO: add dependencies by issue-driven.
case node[:platform]
when 'debian', 'ubuntu', 'mint'
when 'redhat', 'fedora', 'amazon'
  # redhat is including CentOS
when 'osx', 'darwin'
when 'arch'
when 'opensuse'
else
end

package 'git'
