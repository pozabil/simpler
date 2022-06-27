module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :param

      def initialize(method, path, controller, action, param)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @param = param.nil? ? nil : param.to_sym
      end

      def match?(method, path)
        compound_path = path.split('/')
        last_element = compound_path[-1]

        if is_integer?(last_element)
          path = compound_path[0..-2].join('/')
          param_value = compound_path[-1]
        else
          path = compound_path.join('/')
          param_value = nil
        end

        (@method == method) && (path == @path) && (!!@param == !!param_value)
      end

      private

      def is_integer?(string)
        string.to_i.to_s == string
      end
    end
  end
end
