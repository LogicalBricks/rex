class Rex::Attribute
  attr_reader :original, :target

  def initialize(original, target: nil, nested: [])
    @original = original
    @target = target || original 
    @nested = nested
  end

  def with_nested_attributes?
    !@nested.empty?
  end
end
