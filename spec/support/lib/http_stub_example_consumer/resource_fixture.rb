module HttpStubExampleConsumer

  class ResourceFixture

    def self.create(id:rand(10))
      return HttpStubExampleConsumer::Resource.new(id: id, name: Faker::Lorem.sentence)
    end

  end

end
