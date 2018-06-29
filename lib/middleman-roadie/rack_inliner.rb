class RackInliner
  def initialize(app, options = {})
    @app = app
    @path = /^(\/#{ options[:path] }\/)/
    @roadie_mode = options[:mode]
  end

  def call(env)
    status, headers, body = @app.call(env)

    if env['PATH_INFO'].match(@path) && headers.key?('Content-Type') and headers['Content-Type'].start_with?('text/html')
      content = ''

      body.each do |part|
        content << part
      end

      email = transform_html(content)

      headers['Content-Length'] = Rack::Utils.bytesize(email).to_s if headers['Content-Length']
      [status, headers, [email]]
    else
      [status, headers, body]
    end
  ensure
    body.close if body.respond_to?(:close)
  end

  private

  def transform_html(old_html)
    nbsp = Nokogiri::HTML("&nbsp;").text
    document = ::Roadie::Document.new old_html
    document.mode = @roadie_mode
    document.transform.gsub(nbsp, "&nbsp;")
  end
end
