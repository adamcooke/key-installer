Gem::Specification.new do |s|
  s.name = 'key-installer'
  s.version = "1.1"
  s.platform = Gem::Platform::RUBY
  s.summary = "Tiny utility to install SSH keys onto remote machines"
 
   s.files = Dir.glob("{bin,lib}/**/*")
   s.require_path = 'lib'
   s.has_rdoc = false
 
   s.bindir = "bin"
   s.executables << "install-key"
  
   s.author = "Adam Cooke"
   s.email = "adam@atechmedia.com"
   s.homepage = "http://www.atechmedia.com"
end
