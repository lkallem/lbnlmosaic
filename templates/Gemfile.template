source "https://rubygems.org"

# Use GitHub Pages gem for full compatibility
gem "github-pages", group: :jekyll_plugins

# Standard library gems required for Ruby 3.4+
gem "csv"
gem "logger" 
gem "ostruct"
gem "base64"

# Windows and JRuby specific gems
platforms :windows, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :platforms => [:windows]

# Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]

# GitHub Pages and development dependencies
gem "webrick", "~> 1.7"

# Additional gems for better Ruby 3.4+ compatibility
gem "rexml"
gem "fiddle"
