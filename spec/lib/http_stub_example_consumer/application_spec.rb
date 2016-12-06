describe HttpStubExampleConsumer::Application do
  include Rack::Test::Methods

  let(:response)      { last_response }
  let(:response_body) { response.body.to_s }
  let(:response_html) { response_body }

  let(:app) { described_class.new! }

  describe "GET /resource" do

    let(:resources) { [] }

    subject { get "/resource" }

    before(:example) { allow(HttpStubExampleConsumer::API).to receive(:resources).and_return(resources) }

    it "responds with a 200 status code" do
      subject

      expect(response.status).to eql(200)
    end

    it "responds with a content-type that is text/html" do
      subject

      expect(response.headers).to include("Content-Type" => a_string_including("text/html"))
    end

    context "when many resources are present" do

      let(:resources) { (1..3).map { HttpStubExampleConsumer::ResourceFixture.create } }

      it "has the resources in the responses html" do
        subject

        resources.each do |resource|
          expect(response_html).to include(resource.name)
        end
      end

    end

  end

  describe "GET /resource/:id" do

    let(:id) { rand(10) }

    subject { get "/resource/#{id}" }

    before(:example) { allow(HttpStubExampleConsumer::API).to receive(:resource).and_return(resource) }

    context "when the resource is present" do

      let(:resource) { HttpStubExampleConsumer::ResourceFixture.create(id: id) }

      it "responds with a 200 status code" do
        subject

        expect(response.status).to eql(200)
      end

      it "responds with a content-type that is text/html" do
        subject

        expect(response.headers).to include("Content-Type" => a_string_including("text/html"))
      end

      it "has the resource id in the response html" do
        subject

        expect(response_html).to include(resource.id.to_s)
      end

      it "has the resource name in the response html" do
        subject

        expect(response_html).to include(resource.name)
      end

    end

  end

end
