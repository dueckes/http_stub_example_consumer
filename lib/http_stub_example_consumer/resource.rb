module HttpStubExampleConsumer

  class Resource

    attr_reader :id, :name

    def self.from_hash(hash)
      self.new(hash.symbolize_keys)
    end

    def initialize(id:, name:)
      @id   = id
      @name = name
    end

    def ==(other)
      other.is_a?(HttpStubExampleConsumer::Resource) && id == other.id && name == other.name
    end
    alias eql? ==

  end

end
