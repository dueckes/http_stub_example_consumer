module HttpStubExampleConsumer

  class API

    class << self

      def resources
        response_array = JSON.parse(HTTParty.get("http://localhost:5000/resource").body)
        response_array.map { |response_element| HttpStubExampleConsumer::Resource.from_hash(response_element) }
      end

      def resource(id)
        response = HTTParty.get("http://localhost:5000/resource/#{id}")
        raise "Resource with ID #{id} not found" if response.code == 404
        HttpStubExampleConsumer::Resource.from_hash(JSON.parse(response.body))
      end

    end

  end

end
