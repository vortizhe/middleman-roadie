require "middleman-core"


Middleman::Extensions.register :roadie do
  require "middleman-roadie/extension"
  Middleman::RoadieExtension
end
