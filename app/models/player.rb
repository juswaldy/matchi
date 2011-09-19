class Player < ActiveRecord::Base
  has_and_belongs_to_many :teams
  validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :score, :numericality => {:greater_than_or_equal_to => 0}
  validates :assist, :numericality => {:greater_than_or_equal_to => 0}

  def strength
    experience = 1
    @score * 5 + @assist * 3 + experience
  end
end
