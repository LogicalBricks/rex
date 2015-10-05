module Rex
  class Migration
    def migrate(hash_to_be_converted, config: config)
      hash_to_be_converted.each.with_object({}) do |(k, v), hash|
        if rattr = config.nested_for(original: k)
          hash.merge! rattr.target => v
        end
      end
    end
  end
end
