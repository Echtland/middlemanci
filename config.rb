require "uglifier"

after_configuration do
  sprockets.append_path File.join root.to_s, "bower_components"
end

activate :directory_indexes
activate :autoprefixer
activate :gzip

set :relative_links, true
set :css_dir, "assets/stylesheets"
set :js_dir, "assets/javascripts"
set :images_dir, "assets/images"
set :fonts_dir, "assets/fonts"
set :layout, "layouts/application"

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

configure :development do
  activate :livereload
end

configure :build do
  activate :minify_css, :inline => true
  activate :minify_javascript, :inline => true, :compressor => Uglifier.new(:mangle => false, :comments => :none)
  activate :asset_hash
  activate :relative_assets
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.deploy_method = :git
end
