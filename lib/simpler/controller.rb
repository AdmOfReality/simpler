require_relative 'view'

module Simpler
  class Controller

    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name # в виде исключения, бизнес логику лучше не держать в конструкторе
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      default_set_headers
      send(action)
      write_response

      @response.finish # => [200, {}, []]
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def default_set_headers
      @response['content-type'] = 'text/html'
    end

    def write_response
      unless @response.body.any?
        body = render_body
        @response.write(body)
        @response['сontent-дength'] = body.bytesize.to_s
      end
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def render(template)
      if template.is_a?(Hash)
        format = template.keys.first
        content = template[format]

        case format
        when :plain
          @response['content-type'] = 'text/plain'
          @response.body = [content]
        when :html
          @response['content-type'] = 'text/html'
          @response.body = [content]
        when :json
          @response['content-type'] = 'application/json'
          @response.body = [content.to_json]
        else
          raise "Unsupported format"
        end
      else
        @request.env['simpler.template'] = template
      end
    end
  end
end
