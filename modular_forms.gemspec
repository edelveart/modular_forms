# frozen_string_literal: true

require_relative 'lib/modular_forms/version'

Gem::Specification.new do |s|
  s.name        = 'modular_forms'
  s.version     = ModularForms::VERSION
  s.summary     = 'Explore a primer on modular forms through creative coding in Sonic Pi.'
  s.description = 'Modular Forms is an introductory interface for modular form generators, enabling creative algorithms in Sonic Pi.' # rubocop:disable Layout/LineLength
  s.authors     = ['Edgar Armando Delgado Vega']
  s.email       = ['edelve91@gmail.com']
  s.files       = Dir['lib/**/*']
  s.require_paths = ['lib']
  s.homepage    = 'https://github.com/edelveart/modular_forms'
  s.license     = 'MIT'
  s.metadata = {
    'homepage_uri' => s.homepage,
    'source_code_uri' => 'https://github.com/edelveart/modular_forms/'
    # 'documentation_uri' => 'https://github.com/edelveart/modular_forms/',
  }

  s.required_ruby_version = '>= 3.0.0'

  s.extra_rdoc_files = Dir['README.md', 'LICENSE.txt']
  s.rdoc_options    += [
    '--main', 'README.md',
    '--line-numbers',
    '--inline-source',
    '--quiet'
  ]
end
