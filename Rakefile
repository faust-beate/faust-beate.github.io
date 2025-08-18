# Default task is to build the site
task default: :build

task :build do
  sh "jekyll", "build", "--config", "_config.yml,_config.dev.yml"
end

task :serve do
  sh "serveit", "-s", "_site", "jekyll build --config _config.yml,_config.dev.yml"
end

task deploy: :build do
  sh "ssh", "beate-faust-strato", "rm -rf ~/*"
  sh "scp", "-r", File.join(__dir__, "_site", "*"), "beate-faust-strato:~"
end

task :clean do
  sh "jekyll", "clean"
end
