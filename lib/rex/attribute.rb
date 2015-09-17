class Rex::Attribute
  attr_reader :original, :target

  def initialize(original, target: nil)
    @original = original
    @target = target || original 
  end
end
