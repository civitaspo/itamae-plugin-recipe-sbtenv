# Itamae::Plugin::Recipe::Sbtenv

[Itamae](https://github.com/ryotarai/itamae) plugin to install sbt with [sbtenv](https://github.com/sbtenv/sbtenv)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-recipe-sbtenv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-recipe-sbtenv

# Usage
## System wide installation

Install sbtenv to /usr/local/sbtenv or some shared path

### Recipe

```ruby
# your recipe
include_recipe "sbtenv::system"
```

### Node

Use this with `itamae -y node.yml`

```yaml
# node.yml
sbtenv:
  global: sbt-0.13.15
  versions:
    - sbt-0.13.15
    - sbt-0.12.4

  # sbtenv install dir, optional (default: /usr/local/sbtenv)
  sbtenv_root: "/path/to/sbtenv"

  # specify scheme to use in git clone, optional (default: git)
  scheme: https
```

### .bashrc

Recommend to append this to .bashrc in your server.

```bash
export SBTENV_ROOT=/usr/local/sbtenv
export PATH="${SBTENV_ROOT}/bin:${PATH}"
eval "$(sbtenv init -)"
```

## Installation for a user

Install sbtenv to `~#{node[:sbtenv][:user]}/.sbtenv`

### Recipe

```ruby
# your recipe
include_recipe "sbtenv::user"
```

### Node

Use this with `itamae -y node.yml`

```yaml
# node.yml
sbtenv:
  user: civitaspo
  global: sbt-0.13.15
  versions:
    - sbt-0.13.15
    - sbt-0.12.4

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
  sbtenv: {
    user: 'civitaspo',
    global: 'sbt-0.13.15',
    versions: %w[
      sbt-0.13.15
      sbt-0.12.4
    ],
  }
)

include_recipe "sbtenv::user"
```

## License

MIT License
