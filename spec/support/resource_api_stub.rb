module HttpStubExampleConsumer

  class ResourceAPIStub
    include HttpStub::Configurer

    stub_server.host = "localhost"
    stub_server.port = 5000
  end

end
