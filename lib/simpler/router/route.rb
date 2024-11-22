module Simpler
  class Router
    class Route

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
      end

      def match?(method, path)
        @method == method && path_parts_match?(path)
      end

      def extract_params(path)
        route_parts = @path.split('/')
        path_parts = path.split('/')

        params = {}
        route_parts.each_with_index do |part, index|
          if part.start_with?(':')
            params[part[1..-1].to_sym] = path_parts[index]
          end
        end

        params
      end

      private

      def path_parts_match?(path)
        route_parts = @path.split('/')
        path_parts = path.split('/')

        return false if route_parts.size != path_parts.size

        route_parts.each_with_index do |part, index|
          next if part.start_with?(':')
          return false unless part == path_parts[index]
        end

        true
      end

    end
  end
end
