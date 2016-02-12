# -*- encoding: utf-8 -*-
# stub: will_paginate 3.0.7 ruby lib

Gem::Specification.new do |s|
  s.name = 'will_paginate'
  s.version = '3.0.8'
  s.date = '2016-02-11'
  s.license = 'MIT'

  s.summary = 'Pagination plugin for web frameworks and other apps'
  s.description = 'will_paginate provides a simple API for performing paginated queries with Active Record, DataMapper and Sequel, and includes helpers for rendering pagination links in Rails, Sinatra and Merb web apps.'

  s.authors = %w(Mislav Marohnic)
  s.email = 'mislav.marohnic@gmail.com'
  s.homepage = 'https://github.com/mislav/will_paginate/wiki'

  s.require_paths = %w(lib)
  s.files = %w(.gitignore .rspec .travis.yml .utilsrc Gemfile LICENSE README.md Rakefile VERSION errors.lst lib/will_paginate.rb lib/will_paginate/active_record.rb lib/will_paginate/array.rb lib/will_paginate/collection.rb lib/will_paginate/deprecation.rb lib/will_paginate/i18n.rb lib/will_paginate/locale/en.yml lib/will_paginate/page_number.rb lib/will_paginate/per_page.rb lib/will_paginate/railtie.rb lib/will_paginate/version.rb lib/will_paginate/view_helpers.rb lib/will_paginate/view_helpers/action_view.rb lib/will_paginate/view_helpers/link_renderer.rb lib/will_paginate/view_helpers/link_renderer_base.rb spec/.DS_Store spec/collection_spec.rb spec/database.yml spec/fake_rubygems.rb spec/finders/.DS_Store spec/finders/active_record_spec.rb spec/finders/activerecord_test_connector.rb spec/fixtures/admin.rb spec/fixtures/developer.rb spec/fixtures/developers_projects.yml spec/fixtures/project.rb spec/fixtures/projects.yml spec/fixtures/replies.yml spec/fixtures/reply.rb spec/fixtures/schema.rb spec/fixtures/topic.rb spec/fixtures/topics.yml spec/fixtures/user.rb spec/fixtures/users.yml spec/matchers/deprecation_matcher.rb spec/matchers/phrase_matcher.rb spec/matchers/query_count_matcher.rb spec/page_number_spec.rb spec/per_page_spec.rb spec/spec_helper.rb spec/view_helpers/action_view_spec.rb spec/view_helpers/base_spec.rb spec/view_helpers/link_renderer_base_spec.rb spec/view_helpers/view_example_group.rb will_paginate.gemspec)
  s.extra_rdoc_files = %w(README.md lib/will_paginate.rb lib/will_paginate/active_record.rb lib/will_paginate/array.rb lib/will_paginate/collection.rb lib/will_paginate/deprecation.rb lib/will_paginate/i18n.rb lib/will_paginate/page_number.rb lib/will_paginate/per_page.rb lib/will_paginate/railtie.rb lib/will_paginate/version.rb lib/will_paginate/view_helpers.rb lib/will_paginate/view_helpers/action_view.rb lib/will_paginate/view_helpers/link_renderer.rb lib/will_paginate/view_helpers/link_renderer_base.rb LICENSE)
  s.rdoc_options = ['--title', 'WillPaginate', '--main', 'README.md']

  s.add_development_dependency 'gem_hadar', '~> 1.3.1'
  s.add_development_dependency 'rake',      '>= 0'
  s.add_development_dependency 'rspec',     '~> 3.0'
  s.add_development_dependency 'simplecov', '~> 0.10'
  s.add_development_dependency 'sqlite3',   '~> 1.3'
  s.add_development_dependency 'rails',     '~> 4.0'
end
