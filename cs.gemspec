# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cs}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["dgoldhirsch"]
  s.date = %q{2009-07-09}
  s.email = %q{dgoldhirsch@yahoo.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "lib/cs.rb",
     "lib/cs_fibonacci.rb",
     "lib/cs_matrix.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/dgoldhirsch/cs}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Computer Science Library for Ruby}
  s.test_files = [
    "test/cs_benchmark_test.rb",
     "test/cs_mixin_test.rb",
     "test/cs_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
