class Game < ActiveRecord::Base
  validates :team1score, :numericality => {:greater_than_or_equal_to => 0}
  validates :team1score, :numericality => {:greater_than_or_equal_to => 0}
  validate :different_teams

  def different_teams
    errors.add('Error:', 'Can''t have a team playing against itself') unless self.team1id != self.team2id
  end
end
