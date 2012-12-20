require 'erb'
require 'prawn'

base = File.join(File.dirname(__FILE__), "..")
$:.unshift File.join(base, "lib/cmdline")

Dir.glob("lib/cmdline/*.rb") do |file|
  require File.basename file
end

WIDTH = 180

class Layout
  def initialize
    @layout = []
  end
  def <<(item)
    col = item.col
    @layout[col] ||= []
    @layout[col] << item
  end
  def to_pdf(pdf)
    @layout.each do |col|
      next if col.nil?
      col.each do |item|
        item.to_pdf(pdf, col.size)        
      end
    end
  end
end

@stats = Stats.new
@layout = Layout.new
@layout << Skills.new

buffer = []
filename = ARGV[0]
File.open(filename).each_line do |line|
  if line.strip == ''
    @layout << Power.new(buffer)
    buffer = []
    next
  end
  buffer << line
end
@layout << Power.new(buffer) unless buffer.empty?



# Explicit Block
width = 180
puts filename
Prawn::Document.generate(filename.sub(".txt", ".pdf"), :page_layout => :landscape) do |pdf|
  @layout.to_pdf(pdf)
end
