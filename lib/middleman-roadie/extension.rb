require 'roadie'
require 'middleman-core'

# Extension namespace
module Middleman
  class RoadieExtension < Extension
    option :my_option, 'default', 'An example option'

    def initialize(app, options_hash={}, &block)
      # Call super to build options from the options_hash
      super

      # set up your extension
      # puts options.my_option
    end

    def after_configuration
      app.use RackInliner, options
    end

    # A Sitemap Manipulator
    # def manipulate_resource_list(resources)
    # end
    helpers do
      def stylesheet_inline_tag(name)
        name += ".css" unless name.include?(".css")
        css_path = sitemap.resources.select { |p| p.source_file.include?(name) }.first
        "<style type='text/css'>#{css_path.render}</style>"
      end
    end
  end
end

require_relative 'asset_provider'
require_relative 'rack_inliner'
