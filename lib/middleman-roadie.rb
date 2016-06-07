require "middleman-core"


Middleman::Extensions.register :roadie do
  require "middleman-roadie/extension"
  require "middleman-roadie/commands/email_test"
  Middleman::RoadieExtension
end
