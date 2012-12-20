#
# A specification, whose name is meant for display
#
class Spec
  attr_accessor :name, :desc
  def initialize(name, desc)
    @name = name
    @desc = desc
  end
  def to_s
    "#{name} #{desc}"
  end
  def to_pdf
    [
      {:text => @name, :styles => [:bold]},
      {:text => @desc + "\n"}
    ]
  end
end
