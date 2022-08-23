if defined?(Rails)
  ENV['RAILS_ENV'] = Rails.env
end

if ENV['RAILS_ENV'] == 'development'
  threads_count = ENV.fetch('RAILS_MAX_THREADS', 5)
  threads threads_count, threads_count

  port        ENV.fetch('PORT', 3000)
  environment ENV.fetch('RAILS_ENV') { 'development' }
  plugin :tmp_restart
else
  directory './'
  rackup './config.ru'

  pidfile './tmp/pids/puma.pid'
  state_path './tmp/pids/puma.state'

  min_threads_count = ENV.fetch('RAILS_MIN_THREADS', 0)
  max_threads_count = ENV.fetch('RAILS_MAX_THREADS', 16)
  threads min_threads_count, max_threads_count

  port        ENV.fetch('PORT', 3000)
  environment ENV.fetch('RAILS_ENV') { 'development' }

  workers 2

  prune_bundler

  on_restart do
    puts 'Refreshing Gemfile'
    ENV['BUNDLE_GEMFILE'] = './Gemfile'
  end
end
