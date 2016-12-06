module HttpStubExampleConsumer

  class Server < HttpServerManager::Server

    def initialize
      super(name: :server, host: "localhost", port: 3000)
    end

    def start_command
      "rackup"
    end

  end

end
