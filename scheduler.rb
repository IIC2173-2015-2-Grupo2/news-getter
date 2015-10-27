require 'rufus-scheduler'

s = Rufus::Scheduler.new

s.every '780s', first_in: 1 do
  system "ruby loaders_lib/emol_loader.rb >> cron_log.log 2>&1"
end

s.every '780s', first_in: 180 do
  system "ruby loaders_lib/cnn_loader.rb >> cron_log.log 2>&1"
end

s.every '780s', first_in: 360 do
  system "ruby loaders_lib/lacuarta_loader.rb >> cron_log.log 2>&1"
end

s.every '780s', first_in: 540 do
  system "ruby loaders_lib/latercera_loader.rb >> cron_log.log 2>&1"
end

s.every '780s', first_in: 720 do
  system "ruby loaders_lib/soychile_loader.rb >> cron_log.log 2>&1"
end

s.join
