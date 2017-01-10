# vim: set filetype=ruby et sw=2 ts=2:

require 'gem_hadar'

GemHadar do
  name        'will_paginate'
  author      'Mislav Marohnić'
  email       'mislav.marohnic@gmail.com'
  homepage    'https://github.com/mislav/will_paginate/wiki'
  summary     'Pagination plugin for web frameworks and other apps'
  description 'will_paginate provides a simple API for performing paginated queries with Active Record, DataMapper and Sequel, and includes helpers for rendering pagination links in Rails, Sinatra and Merb web apps.'
  readme      'README.md'
  doc_files   << 'LICENSE'
  licenses << 'MIT'
  ignore      '.*.sw[pon]', 'pkg', 'Gemfile.lock', 'coverage', '.rvmrc',
    '.AppleDouble', 'tags', '.DS_Store', '.byebug_history'

  development_dependency 'rake'
  development_dependency 'rspec',         '~>3.0'
  development_dependency 'sqlite3',       '~>1.3'
  development_dependency 'simplecov',     '~>0.10'
  development_dependency 'rails',         '>= 4.0', '<6'

  default_task_dependencies :spec
end
