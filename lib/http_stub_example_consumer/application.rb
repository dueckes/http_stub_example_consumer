module HttpStubExampleConsumer

  class Application < Sinatra::Base

    get "/resource/:id" do
      haml :resource, {}, resource: HttpStubExampleConsumer::API.resource(params[:id])
    end

    get "/resource" do
      haml :resources, {}, resources: HttpStubExampleConsumer::API.resources
    end

  end

end
