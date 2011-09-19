class Game < ActiveRecord::Base
  validates :team1id, :presence => true
  validates :team2id, :presence => true
  validates :score, :numericality => {:greater_than_or_equal_to => 0}
  validates :assist, :numericality => {:greater_than_or_equal_to => 0}
end
