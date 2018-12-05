module Mercedes
  module Configurable
    OPTIONS = %i[token].freeze

    attr_accessor(*OPTIONS)

    def configure
      yield self
    end

    def auth(opts = {})
      "authorization #{opts[:token] || token}"
    end
  end
end
