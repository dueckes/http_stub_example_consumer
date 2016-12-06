module HttpStubExampleConsumer

  class API

    class << self

      def resources
        response_array = JSON.parse(HTTParty.get("#{base_uri}/resource").body)
        response_array.map { |response_element| HttpStubExampleConsumer::Resource.from_hash(response_element) }
      end

      def resource(id)
        response = HTTParty.get("#{base_uri}/resource/#{id}")
        raise "Resource with ID #{id} not found" if response.code == 404
        HttpStubExampleConsumer::Resource.from_hash(JSON.parse(response.body))
      end

      private

      def base_uri
        "http://#{ENV['STUB_HOST']}:5000"
      end

    end

  end

end
