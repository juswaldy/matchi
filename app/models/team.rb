class Team < ActiveRecord::Base
  has_and_belongs_to_many :players
  validates :name, :presence => true, :uniqueness => true
  validates :score, :numericality => {:greater_than_or_equal_to => 0}
  after_initialize :init
  attr_accessor :potential

  def init
    @potential = 0 # Calculated strength of the available players.
  end

  # Sum up all the strengths of each player.
  def strength
    players.map{|p| p.strength}.reduce{|sum,n| sum + n}
  end
end
