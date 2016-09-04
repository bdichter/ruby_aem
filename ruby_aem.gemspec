Gem::Specification.new do |s|
  s.name              = 'ruby_aem'
  s.version           = '0.9.0'
  s.platform          = Gem::Platform::RUBY
  s.authors           = ['Shine Solutions']
  s.email             = ['opensource@shinesolutions.com']
  s.homepage          = 'https://github.com/shinesolutions/ruby_aem'
  s.summary           = 'AEM API Ruby client'
  s.description       = 'ruby_aem is a Ruby client for Adobe Experience Manager (AEM) API, written on top of swagger_aem'
  s.license           = 'Apache 2.0'
  s.required_ruby_version = '>= 1.9'
  s.files             = Dir.glob("{conf,lib}/**/*")
  s.require_paths     = ['lib']
end
