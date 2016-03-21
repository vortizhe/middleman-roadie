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
      app.use Rack, options
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

    class Rack
      def initialize(app, options = {})
        @app = app
        @options = options
      end

      def call(env)
        status, headers, body = @app.call(env)

        if headers.key? 'Content-Type' and headers['Content-Type'] =~ /html/
          content = ''

          body.each do |part|
            content << part
          end

          email = transform_html(content)

          headers['Content-Length'] = email.bytesize.to_s if headers['Content-Length']
          [status, headers, [email]]
        else
          [status, headers, body]
        end
      ensure
        body.close if body.respond_to?(:close)
      end

      private

      def transform_html(old_html)
        document = ::Roadie::Document.new old_html
        @options.apply_to document
        document.transform
      end
    end
  end
end
