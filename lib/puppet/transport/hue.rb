require 'faraday'

module Puppet::Transport
  # The main connection class to a Hue endpoint
  class Hue
    # Initialise this transport with a set of credentials
    def initialize(context, connection_info)
      # provide a default port
      port = connection_info[:port].nil? ? 80 : connection_info[:port]
      @connection = Faraday.new(url: "http://#{connection_info[:host]}:#{port}/api/#{connection_info[:key].unwrap}", ssl: { verify: false })
    end

    # Verifies that the stored credentials are valid, and that we can talk to the target
    def verify(context)
    end

    # Retrieve facts from the target and return in a hash
    def facts(context)
      {
        'operatingsystem': 'philips_hue',
      }
    end

    # Close the connection and release all resources
    def close(context)
      @connection = nil
    end

    # @summary
    # Requests api details from the HUE Hub
    def hue_get(context, url, args = nil)
      url = URI.escape(url) if url
      result = @connection.get(url, args)
      JSON.parse(result.body)
    rescue JSON::ParserError => e
      raise Puppet::ResourceError, "Unable to parse JSON response from HUE API: #{e}"
    end

    # @summary
    #   Sends an update command to the given url/connection
    def hue_put(url, message)
      message = message.to_json
      @connection.put(url, message)
    end
  end
end
