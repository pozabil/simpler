class Logger
  def initialize(app, **options)
    @logfile = options[:logfile]
    @app = app
  end

  def call(env)
    @response = @app.call(env)
    info(env)
    @response
  end

  private

  def info(env)
    content_type = @response[1]['Content-Type']
    status = "#{@response[0]} #{Rack::Utils::HTTP_STATUS_CODES[@response[0]] || "CUSTOM"}"
    controller = env['simpler.controller']
    template = env['simpler.template']
    template &&= template + '.html.erb'

     log = [
      "Request: #{env['REQUEST_METHOD']} #{env['REQUEST_URI']}",
      "Handler: #{controller.class.name if controller}##{env['simpler.action']}",
      "Parameters: #{controller.request.params if controller}",
      "Response: #{status} [#{content_type}] #{template}"
    ].join("\n\r")

    file = File.new(@logfile, "a:UTF-8")
    file.print(log + "\n\r\n\r")
    file.close
  end
end
