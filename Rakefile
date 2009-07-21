require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "cs"
    gem.files = FileList['lib/**/*.rb']
    gem.summary = %Q{Computer Science Library for Ruby}
    gem.email = "dgoldhirsch@yahoo.com"
    gem.homepage = "http://github.com/dgoldhirsch/cs"
    gem.authors = ["dgoldhirsch"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml.yml')
    config = YAML.load(File.read('VERSION.yml.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "cs #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# Code coverage via rcov
namespace :test do

  desc 'Measures test coverage'
  task :coverage do
    rm_f "coverage"
    rm_f "coverage.data"
    rcov = "rcov --aggregate coverage.data --text-summary -I./lib -I./test test/**/*.rb"
    system("#{rcov}")
#    system("#{rcov} --no-html test/unit/*.rb")
#    system("#{rcov} --no-html test/functional/*.rb")
#    system("#{rcov} --html test/integration/*.rb")
#    system("open coverage/index.html") if PLATFORM['darwin']
  end
end


