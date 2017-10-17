# Itamae::Plugin::Recipe::Scalaenv

[Itamae](https://github.com/ryotarai/itamae) plugin to install scala with [scalaenv](https://github.com/scalaenv/scalaenv)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-recipe-scalaenv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-recipe-scalaenv

# Usage
## System wide installation

Install scalaenv to /usr/local/scalaenv or some shared path

### Recipe

```ruby
# your recipe
include_recipe "scalaenv::system"
```

### Node

Use this with `itamae -y node.yml`

```yaml
# node.yml
scalaenv:
  global: scala-2.12.2
  versions:
    - scala-2.11.8
    - scala-2.10.6

  # scalaenv install dir, optional (default: /usr/local/scalaenv)
  scalaenv_root: "/path/to/scalaenv"

  # specify scheme to use in git clone, optional (default: git)
  scheme: https
```

### .bashrc

Recommend to append this to .bashrc in your server.

```bash
export SCALAENV_ROOT=/usr/local/scalaenv
export PATH="${SCALAENV_ROOT}/bin:${PATH}"
eval "$(scalaenv init -)"
```

## Installation for a user

Install scalaenv to `~#{node[:scalaenv][:user]}/.scalaenv`

### Recipe

```ruby
# your recipe
include_recipe "scalaenv::user"
```

### Node

Use this with `itamae -y node.yml`

```yaml
# node.yml
scalaenv:
  user: civitaspo
  global: scala-2.12.2
  versions:
    - scala-2.11.8
    - scala-2.10.6

  # specify scheme to use in git clone, optional (default: git)
  scheme: https

```

## Example

```
$ cd example
$ vagrant up
$ bundle exec itamae ssh --vagrant -y node.yml recipe.rb
```

## MItamae

This plugin can be used for MItamae too. Put this repository under `./plugins` as git submodule.

```rb
node.reverse_merge!(
  scalaenv: {
    user: 'civitaspo',
    global: 'scala-2.12.2',
    versions: %w[
      scala-2.11.8
      scala-2.10.6
    ],
  }
)

include_recipe "scalaenv::user"
```

## License

MIT License
