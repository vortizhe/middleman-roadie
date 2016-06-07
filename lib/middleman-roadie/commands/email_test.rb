require 'middleman-cli'
require 'middleman-roadie/extension'

module Middleman
  module Cli
    class EmailTest < ::Thor::Group
      include Thor::Actions

      check_unknown_options!

      namespace :roadie

      argument :file, type: :string

      def self.exit_on_failure?
        true
      end

      def email_test
        app = Middleman::Application.new
        puts "Sending #{file}"
        mail = ::Mail.new
        mail.from app.config[:email_from]
        mail.to app.config[:email_to]
        mail.subject 'Test it!'
        mail.content_type 'text/html; charset=UTF-8'
        mail.body File.read(file)
        mail.delivery_method :smtp, app.config[:smtp_settings]
        mail.deliver
      end

      Base.register(self, 'roadie:email_test', 'roadie:email_test FILE [options]', 'Send email test')
    end
  end
end
