class Team < ActiveRecord::Base
  has_and_belongs_to_many :players
  validates :score, :numericality => {:greater_than_or_equal_to => 0}
  attr_accessor :players, :strength

  after_initialize :init
  def init
    @players = []
    @strength = 0
  end
end
