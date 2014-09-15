Gem::Specification.new do |s|
    s.name        = 'RubyONVIF'
    s.version     = '0.1.7'
    s.date        = '2014-09-12'
    s.summary     = "RubyONVIF"
    s.description = "RubyONVIF"
    s.authors     = ["Cyrus"]
    s.require_paths = ['lib']
    s.files = Dir.glob("lib/**/*") + %w{Gemfile RubyONVIF.gemspec}

    s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
    s.add_dependency 'em_ws_discovery'
    s.add_dependency 'em-http-request'
    s.add_dependency 'em-http-server'
    s.add_dependency 'activesupport'
    s.add_dependency 'akami'
end

