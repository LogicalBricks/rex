module Rex
  class Migration
    def migrate(hash_to_be_converted, config: config)
      hash_to_be_converted.each.with_object({}) do |(k, v), hash|
        hash.merge! k => v if config.include_original?(k)
      end
    end
  end
end
