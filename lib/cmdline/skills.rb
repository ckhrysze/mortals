class Skills
  def initialize
    @skills = Skill.new('Acrobatics', 'dex')
    @skills = Skill.new('Arcana', 'int')
    @skills = Skill.new('Athletics', 'str')
    @skills = Skill.new('Bluff', 'cha')
    @skills = Skill.new('Diplomacy', 'cha')
    @skills = Skill.new('Dungeoneering', 'wis')
    @skills = Skill.new('Endurance', 'con')
    @skills = Skill.new('Heal', 'wis')
    @skills = Skill.new('History', 'int')
    @skills = Skill.new('Insight', 'wis')
    @skills = Skill.new('Intimidate', 'cha')
    @skills = Skill.new('Nature', 'wis')
    @skills = Skill.new('Perception', 'wis')
    @skills = Skill.new('Religion', 'int')
    @skills = Skill.new('Stealth', 'dex')
    @skills = Skill.new('Streetwise', 'cha')
    @skills = Skill.new('Thievery', 'dex')
  end
  def col
    0
  end
  def to_pdf(pdf, *args)
  end
end

class Skill
  attr_accessor :name, :stat
  def initialize(name, stat)
    @name = name
    @stat = stat.to_sym
  end
end

