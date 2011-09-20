class WelcomeController < ApplicationController
  def index
    @games = Game.all.sort_by{|x| [x.date, -(x.team1score + x.team2score)]}
  end

  def assign(team, player)
    team.players.push(player)
    team.potential += player.strength
  end

  # Get info for the list of available players,
  # then sort the list based on strength, and then
  # break up the list into 3 player slices and assign
  # to each team.
  # Then pick the weakest player and assign it to
  # balance the number of players in teams.
  def suggestion
    @present = Player.find_all_by_id(params[:player_ids])
    playersByStrength = @present.sort_by{|x| [-x.strength, x.nickname]}
    @team1 = Team.new
    @team2 = Team.new
    playersByStrength.each_slice(3) do |p1, p2, p3|
      # Assign the strongest player in this slice to
      # the weaker team, and the next strongest to the
      # other team.
      if @team1.potential > @team2.potential
        assign(@team2, p1)
        assign(@team1, p2) if p2
      else
        assign(@team1, p1)
	assign(@team2, p2) if p2
      end

      # The third player p3 is assigned to the weaker team
      # and the fourth player p4 is the weakest player that
      # is assigned to the other team to balance the number
      # of players.
      p4 = playersByStrength.pop
      if @team1.potential > @team2.potential
        assign(@team2, p3) if p3
	assign(@team1, p4) if p4
      else
        assign(@team1, p3) if p3
	assign(@team2, p4) if p4
      end
    end
    @max = [@team1.players.to_a.count, @team2.players.to_a.count].max - 1
  end

  # Save game and teams data.
  def accept
    @message = []
    team1 = Team.new(params[:team1])
    team2 = Team.new(params[:team2])
    success = []
    if team1.save
      success.push(team1.name)
    end
    if team2.save
      success.push(team2.name)
    end
    msg = (success.count == 0 ? 'Failure' : 'Success')
    msg += ' saving team'
    msg += (success.count == 2 ? 's ' : ' ')
    msg += success.join(' and ')
    msg += " data!"
    @message.push(msg)
    @game = Game.new(params[:game])
    @game.team1id = team1.id
    @game.team2id = team2.id
    msg = ''
    if @game.save
      msg += 'Success'
    else
      msg += 'Failure'
    end
    msg += ' saving game data!'
    @message.push(msg)
  end
end
