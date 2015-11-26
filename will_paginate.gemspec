# -*- encoding: utf-8 -*-
# stub: will_paginate 3.0.7 ruby lib

Gem::Specification.new do |s|
  s.name = "will_paginate"
  s.version = "3.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Mislav Marohni\u{107}"]
  s.date = "2015-11-27"
  s.description = "will_paginate provides a simple API for performing paginated queries with Active Record, DataMapper and Sequel, and includes helpers for rendering pagination links in Rails, Sinatra and Merb web apps."
  s.email = "mislav.marohnic@gmail.com"
  s.extra_rdoc_files = ["README.md", "lib/will_paginate.rb", "lib/will_paginate/active_record.rb", "lib/will_paginate/array.rb", "lib/will_paginate/collection.rb", "lib/will_paginate/deprecation.rb", "lib/will_paginate/i18n.rb", "lib/will_paginate/page_number.rb", "lib/will_paginate/per_page.rb", "lib/will_paginate/railtie.rb", "lib/will_paginate/version.rb", "lib/will_paginate/view_helpers.rb", "lib/will_paginate/view_helpers/action_view.rb", "lib/will_paginate/view_helpers/link_renderer.rb", "lib/will_paginate/view_helpers/link_renderer_base.rb", "LICENSE"]
  s.files = [".DS_Store", ".gitignore", ".rspec", ".travis.yml", ".utilsrc", "Gemfile", "LICENSE", "README.md", "Rakefile", "VERSION", "errors.lst", "lib/will_paginate.rb", "lib/will_paginate/active_record.rb", "lib/will_paginate/array.rb", "lib/will_paginate/collection.rb", "lib/will_paginate/deprecation.rb", "lib/will_paginate/i18n.rb", "lib/will_paginate/locale/en.yml", "lib/will_paginate/page_number.rb", "lib/will_paginate/per_page.rb", "lib/will_paginate/railtie.rb", "lib/will_paginate/version.rb", "lib/will_paginate/view_helpers.rb", "lib/will_paginate/view_helpers/action_view.rb", "lib/will_paginate/view_helpers/link_renderer.rb", "lib/will_paginate/view_helpers/link_renderer_base.rb", "spec/.DS_Store", "spec/collection_spec.rb", "spec/database.yml", "spec/fake_rubygems.rb", "spec/finders/.DS_Store", "spec/finders/active_record_spec.rb", "spec/finders/activerecord_test_connector.rb", "spec/fixtures/admin.rb", "spec/fixtures/developer.rb", "spec/fixtures/developers_projects.yml", "spec/fixtures/project.rb", "spec/fixtures/projects.yml", "spec/fixtures/replies.yml", "spec/fixtures/reply.rb", "spec/fixtures/schema.rb", "spec/fixtures/topic.rb", "spec/fixtures/topics.yml", "spec/fixtures/user.rb", "spec/fixtures/users.yml", "spec/matchers/deprecation_matcher.rb", "spec/matchers/phrase_matcher.rb", "spec/matchers/query_count_matcher.rb", "spec/page_number_spec.rb", "spec/per_page_spec.rb", "spec/spec_helper.rb", "spec/view_helpers/action_view_spec.rb", "spec/view_helpers/base_spec.rb", "spec/view_helpers/link_renderer_base_spec.rb", "spec/view_helpers/view_example_group.rb", "will_paginate.gemspec"]
  s.homepage = "https://github.com/mislav/will_paginate/wiki"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--title", "WillPaginate - Pagination plugin for web frameworks and other apps", "--main", "README.md"]
  s.rubygems_version = "2.5.0"
  s.summary = "Pagination plugin for web frameworks and other apps"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<gem_hadar>, ["~> 1.3.1"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<sqlite3>, ["~> 1.3"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.10"])
      s.add_development_dependency(%q<rails>, ["~> 4.0"])
    else
      s.add_dependency(%q<gem_hadar>, ["~> 1.3.1"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<sqlite3>, ["~> 1.3"])
      s.add_dependency(%q<simplecov>, ["~> 0.10"])
      s.add_dependency(%q<rails>, ["~> 4.0"])
    end
  else
    s.add_dependency(%q<gem_hadar>, ["~> 1.3.1"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<sqlite3>, ["~> 1.3"])
    s.add_dependency(%q<simplecov>, ["~> 0.10"])
    s.add_dependency(%q<rails>, ["~> 4.0"])
  end
end
