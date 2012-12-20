#
# A named field, where the name is not meant for display
#
class Field
  attr_accessor :name, :value
  def initialize(name, value)
    @name = name
    @value = value
  end
  def to_text
    "#{value}"
  end
  def to_pdf
    value + "\n"
  end
  def to_s
    value
  end
end
