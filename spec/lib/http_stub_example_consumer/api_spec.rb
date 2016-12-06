describe HttpStubExampleConsumer::API do

  let(:resource_api_stub) { HttpStubExampleConsumer::ResourceAPIStub.stub_server }

  before(:example) { resource_api_stub.has_started! }

  after(:example) { resource_api_stub.recall_stubs! }

  describe "::resources" do

    subject { described_class.resources }

    context "when the service has resources" do

      before(:example) { resource_api_stub.activate!("Get: Many Resources") }

      it "returns an array containing the resources" do
        expected_resources = [
          HttpStubExampleConsumer::Resource.new(id: 1, name: "First Resource"),
          HttpStubExampleConsumer::Resource.new(id: 2, name: "Second Resource"),
          HttpStubExampleConsumer::Resource.new(id: 3, name: "Third Resource")
        ]

        expect(subject).to eq(expected_resources)
      end

    end

    context "when the service has no resources" do

      before(:example) { resource_api_stub.activate!("Get: No Resources") }

      it "returns an empty array" do
        expect(subject).to eql([])
      end

    end

  end

  describe "::resource" do

    let(:id) { 1 }

    subject { described_class.resource(id) }

    context "when the service returns a resource having the provided ID" do

      before(:example) { resource_api_stub.activate!("Get: One Resource") }

      it "returns the resource" do
        expect(subject).to eql(HttpStubExampleConsumer::Resource.new(id: 1, name: "Sole Resource"))
      end

    end

    context "when the service returns no resource" do

      before(:example) { resource_api_stub.activate!("Get: Resource Not Found") }

      it "raises an error indicating the resource could not be found" do
        expect { subject }.to raise_error("Resource with ID #{id} not found")
      end

    end

  end

end
