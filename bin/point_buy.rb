class NotEnoughPoints < StandardError; end
class TooManyPoints < StandardError; end

class Stats

  attr_accessor :str, :dex, :con, :wis, :int, :cha

  def initialize
    @str = @dex = @con = @wis = @int = 10
    @cha = 8
    @remaining = 22
  end

  def swap(first, second)
    tmp = send(first)
    send("#{first}=", send(second))
    send("#{second}=", tmp)
  end

  def add(stat)
    case send(stat)
    when 8 .. 12
      lose_points(1)
    when 13 .. 15
      lose_points(2)
    when 16
      lose_points(3)
    when 17
      lose_points(4)
    else
      raise "Cannot assign higher than 18 during character creation"
    end
    incr_stat(stat)
  rescue NotEnoughPoints => e
    raise "Not enough points to raise #{stat.to_s}"
  end

  def subtract(stat)
    case send(stat)
    when 18
      gain_points(4)
    when 17
      gain_points(3)
    when 14 .. 16
      gain_points(2)
    when 9 .. 13
      gain_points(1)
    else
      raise "Cannot assign lower than 8 during character creation"
    end
    decr_stat(stat)
  end

  def incr_stat(stat); send("#{stat}=", send(stat)+1); end
  def decr_stat(stat); send("#{stat}=", send(stat)-1); end

  def gain_points(amount)
    if @remaining + amount > 22
      raise TooManyPoints
    end
    @remaining += amount
  end

  def lose_points(amount)
    if @remaining - amount < 0
      raise NotEnoughPoints
    end
    @remaining -= amount
  end

  def to_s
    [
      "Str:     #{str}",
      "Dex:     #{dex}",
      "Con:     #{con}",
      "Wis:     #{wis}",
      "Int:     #{int}",
      "Cha:     #{cha}",
      "-----------",
      "Points:  #{@remaining}"
    ].join("\n")
  end
end

def add_menu
  [
    "1. Str",
    "2. Dex",
    "3. Con",
    "4. Wis",
    "5. Int",
    "6. Cha",
    "7. Exit"
  ].join("\n")
end

def main_menu
  puts 'Not implemented'
  exit
end

def sub_menu
  
end

def cmd_line
  s = Stats.new

  menu = :add_menu

  loop do
    puts '_'*50
    puts
    puts s
    puts
    puts send(menu) # because this is the only reasonable first action

    # get the command, stripped of whitespace
    cmd = gets.chomp

    range = (1 .. 8)

    unless range.map(&:to_s).include? cmd
      puts 'Invalid command'
      next
    end

    begin
      case cmd.to_i
      when 1
        s.add(:str)
      when 2
        s.add(:dex)
      when 3
        s.add(:con)
      when 4
        s.add(:wis)
      when 5
        s.add(:int)
      when 6
        s.add(:cha)
      when 7
        exit
      end
    rescue => e
      puts e
    end
  end
end

cmd_line
