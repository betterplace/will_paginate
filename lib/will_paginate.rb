# You will paginate!
module WillPaginate
end
require 'rails'

require 'will_paginate/active_record'
require 'will_paginate/array'
require 'will_paginate/collection'
require 'will_paginate/deprecation'
require 'will_paginate/i18n'
require 'will_paginate/page_number'
require 'will_paginate/per_page'
require 'will_paginate/version'
require 'will_paginate/view_helpers/link_renderer'
require 'will_paginate/view_helpers/link_renderer_base'
require 'will_paginate/railtie' if defined?(Rails::Railtie)
