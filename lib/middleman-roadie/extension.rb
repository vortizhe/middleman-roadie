require 'mail'
require 'roadie'
require 'middleman-core'

# Extension namespace
module Middleman
  class RoadieExtension < Extension
    option :path, 'email', 'Path to render override'

    def initialize(app, options_hash={}, &block)
      # Call super to build options from the options_hash
      super

      # set up your extension
      # puts options.my_option
    end

    def after_configuration
      app.use RackInliner, options
    end

    def after_build(builder)
      @app_config = app.config
      Dir.glob("#{app.config[:build_dir]}/email/**/*.html") do |file|
        app.logger.info "Sending #{file.to_s}"
        mail = ::Mail.new
        mail.from app.config[:email_from]
        mail.to app.config[:email_to]
        mail.subject 'Test it!'
        mail.content_type 'text/html; charset=UTF-8'
        mail.body File.read(file)
        mail.delivery_method :smtp, app.config[:smtp_settings]
        mail.deliver
      end
    end

    # A Sitemap Manipulator
    # def manipulate_resource_list(resources)
    # end
    helpers do
      def stylesheet_inline_tag(name, import = true)
        ignore_tag = import ? '' : 'data-roadie-ignore'
        name += ".css" unless name.include?(".css")
        css_path = sitemap.resources.select { |p| p.source_file.include?(name) }.first
        "<style type='text/css' #{ignore_tag}>#{css_path.render}</style>"
      end
    end
  end
end

require_relative 'asset_provider'
require_relative 'rack_inliner'
