set :output, "./cron_log.log"

every 2.hour do |variable|
  command "bundle exec ruby fpl_tracker.rb"
end
