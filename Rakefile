# Default task is to build the site
task default: :build

task :build do
  sh "jekyll", "build", "--config", "_config.yml,_config.dev.yml"
end

task :serve do
  sh "serveit", "-s", "_site", "jekyll build --config _config.yml,_config.dev.yml"
end

task :clean do
  sh "jekyll", "clean"
end
