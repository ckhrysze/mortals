class Power
  attr_accessor :column, :color, :title, :desc, :frequency, :action_type, :specs, :col, :row

  def initialize(lines)
    @specs = []
    parse(lines.map(&:strip))
  end

  def parse(lines)
    @col, @row = lines.shift.split(',').map(&:to_i)
    @title = Field.new('title', lines.shift)

    desc = ''
    loop do
      line = lines.shift
      if parse_frequency(line)
        @frequency = Field.new('freq', line)
        break
      end
      desc += line
    end

    @desc = Field.new('desc', desc)

    @action_type = Field.new('action', lines.shift)

    parse_specs(lines)
    @remainder = lines
  end

  def parse_specs(lines)
    regex = /[A-Z]\w+\s?\w*:/
    lines.each do |line|
      if line =~ regex
        name = $&
        desc = line.sub(name, '')
        @specs << Spec.new(name, desc)
      else
        unless line.match(/^\w/)
          line = "\n" + line
        end
        @specs.last.desc += " #{line}"
      end
    end
  end

  def parse_frequency(line)
    case line
    when /^At-Will/
      @color = '518d65'
    when /^Encounter/
      @color = '841730'
    when /^Daily/
      @color = '3f4140'
    else
      return false
    end

    true
  end

  def to_pdf(pdf, max_col)
    x = WIDTH*@col
    y = 560 - 560/(max_col) * @row

    pdf.fill_color @color
    pdf.fill_rectangle [x, y+5], WIDTH-5, 14

    pdf.formatted_text_box(
      [{  :text => title.to_s,
          :color => 'FFFFFF',
          :size => 10
        }],
      :at => [x+2, y+2],
      :width => WIDTH-5
      )

    pdf.fill_color '000000'

    text_segments = [
      {:text => frequency.to_pdf},
      {:text => action_type.to_pdf}
    ] + @specs.map(&:to_pdf).flatten

    pdf.formatted_text_box(
      text_segments,
      :at => [x, y-10],
      :width => WIDTH-5,
      :size => 8
      )
  end

end
