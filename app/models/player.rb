class Player < ActiveRecord::Base
  has_and_belongs_to_many :teams
  validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :score, :numericality => {:greater_than_or_equal_to => 0}
  validates :assist, :numericality => {:greater_than_or_equal_to => 0}

  # Algorithm for calculating the strength/grade of the player.
  def strength
    experience = 1 # TODO: This should be the number of times s/he has played
    self.score * 5 + self.assist * 3 + experience
  end
end
