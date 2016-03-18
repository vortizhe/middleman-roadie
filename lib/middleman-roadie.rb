require "middleman-core"

Middleman::Extensions.register :middleman-roadie do
  require "my-extension/extension"
  MyExtension
end
