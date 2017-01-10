# -*- encoding: utf-8 -*-
# stub: will_paginate 4.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "will_paginate".freeze
  s.version = "4.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mislav Marohni\u0107".freeze]
  s.date = "2017-01-10"
  s.description = "will_paginate provides a simple API for performing paginated queries with Active Record, DataMapper and Sequel, and includes helpers for rendering pagination links in Rails, Sinatra and Merb web apps.".freeze
  s.email = "mislav.marohnic@gmail.com".freeze
  s.extra_rdoc_files = ["README.md".freeze, "lib/will_paginate.rb".freeze, "lib/will_paginate/active_record.rb".freeze, "lib/will_paginate/array.rb".freeze, "lib/will_paginate/collection.rb".freeze, "lib/will_paginate/deprecation.rb".freeze, "lib/will_paginate/i18n.rb".freeze, "lib/will_paginate/page_number.rb".freeze, "lib/will_paginate/per_page.rb".freeze, "lib/will_paginate/railtie.rb".freeze, "lib/will_paginate/version.rb".freeze, "lib/will_paginate/view_helpers.rb".freeze, "lib/will_paginate/view_helpers/action_view.rb".freeze, "lib/will_paginate/view_helpers/link_renderer.rb".freeze, "lib/will_paginate/view_helpers/link_renderer_base.rb".freeze, "LICENSE".freeze]
  s.files = [".DS_Store".freeze, ".gitignore".freeze, ".rspec".freeze, ".travis.yml".freeze, ".utilsrc".freeze, "Gemfile".freeze, "LICENSE".freeze, "README.md".freeze, "Rakefile".freeze, "VERSION".freeze, "errors.lst".freeze, "lib/will_paginate.rb".freeze, "lib/will_paginate/active_record.rb".freeze, "lib/will_paginate/array.rb".freeze, "lib/will_paginate/collection.rb".freeze, "lib/will_paginate/deprecation.rb".freeze, "lib/will_paginate/i18n.rb".freeze, "lib/will_paginate/locale/en.yml".freeze, "lib/will_paginate/page_number.rb".freeze, "lib/will_paginate/per_page.rb".freeze, "lib/will_paginate/railtie.rb".freeze, "lib/will_paginate/version.rb".freeze, "lib/will_paginate/view_helpers.rb".freeze, "lib/will_paginate/view_helpers/action_view.rb".freeze, "lib/will_paginate/view_helpers/link_renderer.rb".freeze, "lib/will_paginate/view_helpers/link_renderer_base.rb".freeze, "spec/.DS_Store".freeze, "spec/collection_spec.rb".freeze, "spec/database.yml".freeze, "spec/fake_rubygems.rb".freeze, "spec/finders/.DS_Store".freeze, "spec/finders/active_record_spec.rb".freeze, "spec/finders/activerecord_test_connector.rb".freeze, "spec/fixtures/admin.rb".freeze, "spec/fixtures/developer.rb".freeze, "spec/fixtures/developers_projects.yml".freeze, "spec/fixtures/project.rb".freeze, "spec/fixtures/projects.yml".freeze, "spec/fixtures/replies.yml".freeze, "spec/fixtures/reply.rb".freeze, "spec/fixtures/schema.rb".freeze, "spec/fixtures/topic.rb".freeze, "spec/fixtures/topics.yml".freeze, "spec/fixtures/user.rb".freeze, "spec/fixtures/users.yml".freeze, "spec/matchers/deprecation_matcher.rb".freeze, "spec/matchers/phrase_matcher.rb".freeze, "spec/matchers/query_count_matcher.rb".freeze, "spec/page_number_spec.rb".freeze, "spec/per_page_spec.rb".freeze, "spec/spec_helper.rb".freeze, "spec/view_helpers/action_view_spec.rb".freeze, "spec/view_helpers/base_spec.rb".freeze, "spec/view_helpers/link_renderer_base_spec.rb".freeze, "spec/view_helpers/view_example_group.rb".freeze, "will_paginate.gemspec".freeze]
  s.homepage = "https://github.com/mislav/will_paginate/wiki".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--title".freeze, "WillPaginate - Pagination plugin for web frameworks and other apps".freeze, "--main".freeze, "README.md".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Pagination plugin for web frameworks and other apps".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<gem_hadar>.freeze, ["~> 1.9.1"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.10"])
      s.add_development_dependency(%q<rails>.freeze, ["< 6", ">= 4.0"])
    else
      s.add_dependency(%q<gem_hadar>.freeze, ["~> 1.9.1"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.10"])
      s.add_dependency(%q<rails>.freeze, ["< 6", ">= 4.0"])
    end
  else
    s.add_dependency(%q<gem_hadar>.freeze, ["~> 1.9.1"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.10"])
    s.add_dependency(%q<rails>.freeze, ["< 6", ">= 4.0"])
  end
end
