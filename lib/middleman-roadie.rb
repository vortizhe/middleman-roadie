require "middleman-core"

require "middleman-roadie/version"

Middleman::Extensions.register :roadie do
  require "middleman-roadie/extension"
  ::Middleman::Roadie
end
