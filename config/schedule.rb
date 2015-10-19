#First we set some configs
set :output, "./config/cron_log.log"
set :job_template, "/bin/bash --login -l -c ':job'"


#Here are the cron jobs to be done
every '1,14,27,40,53 * * * *' do
  puts "Emol cron job"
  command "cd #{Dir.pwd};rvm use 2.2.2; ruby loaders_lib/emol_loader.rb >> cron_log.log 2>&1"
end

every '3,16,29,42,55 * * * *' do
  puts "CNN cron job"
  command "cd #{Dir.pwd};rvm use 2.2.2; ruby loaders_lib/cnn_loader.rb >> cron_log.log 2>&1"
end

every '5,18,31,44,57 * * * *' do
  puts "La Cuarta cron job"
  command "cd #{Dir.pwd};rvm use 2.2.2; ruby loaders_lib/lacuarta_loader.rb >> cron_log.log 2>&1"
end

every '7,20,33,46,59 * * * *' do
  puts "La Tercera cron job"
  command "cd #{Dir.pwd};rvm use 2.2.2; ruby loaders_lib/latercera_loader.rb >> cron_log.log 2>&1"
end

every '10,23,36,49 * * * *' do
  puts "Soy Chile cron job"
  command "cd #{Dir.pwd};rvm use 2.2.2; ruby loaders_lib/soychile_loader.rb >> cron_log.log 2>&1"
end
