class Stats
  attr_accessor :lvl, :str, :dex, :con, :wis, :int, :cha

  def initialize(stats={})
    @lvl = stats.fetch(:lvl, 1)
    @str = stats.fetch(:str, 1)
    @dex = stats.fetch(:dex, 1)
    @con = stats.fetch(:con, 1)
    @wis = stats.fetch(:wis, 1)
    @int = stats.fetch(:int, 1)
    @cha = stats.fetch(:cha, 1)
  end
end
