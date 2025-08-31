require "fileutils"
require "tilt"
require "tilt/slim"
require "slim/include"
require "kramdown"

class StaticPageBuilder
  attr_reader :rootpath
  def initialize(rootpath)
    @rootpath = rootpath
  end

  def build_into(destpath)
    puts "Building #{rootpath} into #{destpath}"
    FileUtils.rm_rf(destpath)
    FileUtils.mkdir_p(destpath)
    Dir.glob(File.join(rootpath, "assets", "*")).each do |asset|
      FileUtils.cp_r(asset, File.join(destpath))
    end
    pages
      .each { puts _1 }
      .each { _1.render_to(destpath) }
  end

  def pages
     Dir.glob(File.join(rootpath, "**", "*.md"))
       .map { Page.new(pagepath(_1), _1, templatepath) }
  end

  def pagepath(filepath)
    filepath.sub(rootpath, "")
      .then { File.basename(_1, ".md") }
  end

  def templatepath
    File.join(rootpath, "views", "layout.slim")
  end
end

class Page
  attr_reader :path, :filepath, :templatepath
  def initialize(path, filepath, templatepath)
    @path         = path
    @filepath     = filepath
    @templatepath = templatepath
  end

  def content
    File.read(filepath)
      .then { remove_frontmatter(_1) }
  end

  def remove_frontmatter(str)
    str.gsub(/\A---.*?---\s*/m, "")
  end

  def html
    Kramdown::Document.new(content).to_html
  end

  def template
    Tilt::SlimTemplate.new(templatepath)
  end

  def render
    template.render { html }
  end

  def render_to(destpath)
    File.write(File.join(destpath, path + ".html"), render)
  end

  def to_s = "<Page #{path}>"
end
