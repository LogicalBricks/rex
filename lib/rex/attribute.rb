class Rex::Attribute
  attr_reader :original, :target, :nested

  def initialize(original, target: nil, nested: [])
    @original = original
    @target = target || original 
    @nested = nested
  end

  def with_nested_attributes?
    !@nested.empty?
  end

  def original?(attr)
    @original == attr
  end

  def target?(attr)
    @target == attr
  end

  def include_original?(attr)
    !!nested.find{|n| n.original?(attr) }
  end

  def include_target?(attr)
    !!nested.find{|n| n.target?(attr) }
  end
end
