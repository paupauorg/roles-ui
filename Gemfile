source "http://rubygems.org"

# Declare your gem's dependencies in roles_ui.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

group :test do
  # Mac specific gems
  if RUBY_PLATFORM =~ /darwin/i
    gem 'rb-fsevent' # Allows gems (e.g. guard) to use FSEvent instead of filesystem polling
    gem 'terminal-notifier-guard'
  end

  # Linux specific gems
  if RUBY_PLATFORM =~ /linux/i
    gem 'rb-inotify' # Allows gems (e.g. guard) to use inotify instead of filesystem polling
    gem 'libnotify' # Allows gems (e.g. guard) to send notifications to Libnotify on Linux
  end
end
