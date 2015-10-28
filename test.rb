require './loader'

Dir["./source_lib/*.json"].each do |source|
  Loader.load(source)
  sleep(5)
end
