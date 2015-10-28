require './loader'

Dir["./source_lib/*.json"].each do |source|
  Loader.load(source)

end
