require 'mercedes/configurable'
require 'mercedes/version'

module Mercedes
  class << self
    include Mercedes::Configurable
  end
end

require 'mercedes/client'
