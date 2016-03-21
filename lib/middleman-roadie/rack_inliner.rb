class RackInliner
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
    document.transform
  end
end
