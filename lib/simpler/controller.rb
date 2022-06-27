require_relative 'view'

module Simpler
  class Controller

    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
      @headers = {}
    end

    def make_response(action, param)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action
      
      set_custom_param(param)
      set_default_headers
      send(action)
      set_custom_headers
      write_response

      @response.finish
    end

    private

    attr_reader :headers

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def set_custom_headers
      @headers.each { |k, v| @response[k] = v}
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def params
      @request.params
    end

    def set_custom_param(param)
      if !!param
        param_value = @request.env['PATH_INFO'].split('/')[-1]
        params[param] = param_value
      end
    end

    def render(template)
      @request.env['simpler.template'] = template
    end

    def status(number)
      @response.status = number
    end

  end
end
