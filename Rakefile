require_relative "lib/static_page_builder"

# Default task is to build the site
task default: :build

task :build do
  StaticPageBuilder
    .new(__dir__)
    .build_into(File.join(__dir__, "_site"))
end

task :serve do
  sh "serveit", "-s", "_site", "rake build"
end

task :deploy do
  sh "jekyll", "build", "--config", "_config.yml"
  sh "ssh", "beate-faust-strato", "rm -rf ~/*"
  sh "scp", "-r", *Dir.glob("_site/*"), "beate-faust-strato:~"
end

task :clean do
  sh "jekyll", "clean"
end
