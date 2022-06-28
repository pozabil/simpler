require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      if template.is_a?(Hash)
        data = template.first[1]
        self.template = nil
        data
      else
        template = File.read(template_path)
        ERB.new(template).result(binding)
      end
    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end

    def template=(value)
      @env['simpler.template'] = value
    end

    def template_path
      self.template = template || [controller.name, action].join('/')

      Simpler.root.join(VIEW_BASE_PATH, "#{template}.html.erb")
    end

  end
end
