describe HttpStubExampleConsumer::Resource do

  let(:id)       { rand(10) }
  let(:name)     { Faker::Lorem.word }

  let(:resource) { described_class.new(id: id, name: name) }

  describe "::from_hash" do

    subject { described_class.from_hash(hash) }

    context "when the hash has string attributes" do

      let(:hash) { { "id": id, "name": name } }

      it "returns a resource with the provided ID" do
        expect(subject.id).to eql(id)
      end

      it "returns a resource with the provided name" do
        expect(subject.name).to eql(name)
      end

    end

  end

  shared_examples_for "an attribute based equality method" do

    context "when the other object is the same" do

      let(:other) { resource }

      it "returns true" do
        expect(subject).to eql(true)
      end

    end

    context "when the other object has equal attributes" do

      let(:other) { described_class.new(id: id, name: name) }

      it "returns true" do
        expect(subject).to eql(true)
      end

    end

    context "when the other object has a different ID" do

      let(:other) { described_class.new(id: id + 1, name: name) }

      it "returns false" do
        expect(subject).to eql(false)
      end

    end

    context "when the other object has a different name" do

      let(:other) { described_class.new(id: id, name: "#{name} #{Faker::Lorem.word}") }

      it "returns false" do
        expect(subject).to eql(false)
      end

    end

    context "when the other object is another type" do

      let(:other) { "some other type" }

      it "returns false" do
        expect(subject).to eql(false)
      end

    end

  end

  describe "#==" do

    subject { resource == other }

    it_behaves_like "an attribute based equality method"

  end

  describe "#eql?" do

    subject { resource.eql?(other) }

    it_behaves_like "an attribute based equality method"

  end

end
