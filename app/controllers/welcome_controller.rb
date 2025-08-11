class WelcomeController < ApplicationController
  def index
    @games = Game.all.sort_by{|x| [x.date, -(x.team1score + x.team2score)]}
  end

  def assign(team, player)
    team.players.push(player)
    team.potential += player.strength
  end

  def algo1(players) 
    # Sort the list based on strength, and then break up
    # the list into 2 player slices and assign alternately.
    playersByStrength = players.sort_by{|x| [-x.strength, x.nickname]}
    team1 = Team.new
    team2 = Team.new
    playersByStrength.each_slice(2) do |p1, p2|
      # Assign the strongest player in this slice to
      # the weaker team, and the next strongest to the
      # other team.
      if team1.potential > team2.potential
        assign(team2, p1)
        assign(team1, p2) if p2
      else
        assign(team1, p1)
	assign(team2, p2) if p2
      end
    end
    [team1, team2]
  end

  def algo2(players)
    # Sort the list based on strength, and then break up
    # the list into 3 player slices and assign to teams.
    # Then pick the weakest player and assign it to
    # balance the number of players in teams.
    playersByStrength = players.sort_by{|x| [-x.strength, x.nickname]}
    team1 = Team.new
    team2 = Team.new
    playersByStrength.each_slice(3) do |p1, p2, p3|
      # Assign the strongest player in this slice to
      # the weaker team, and the next strongest to the
      # other team.
      if team1.potential > team2.potential
        assign(team2, p1)
        assign(team1, p2) if p2
      else
        assign(team1, p1)
	assign(team2, p2) if p2
      end

      # The third player p3 is assigned to the weaker team
      # and the fourth player p4 is the weakest player that
      # is assigned to the other team to balance the number
      # of players.
      p4 = playersByStrength.pop
      if team1.potential > team2.potential
        assign(team2, p3) if p3
	assign(team1, p4) if p4 and p4 != p3
      else
        assign(team1, p3) if p3
	assign(team2, p4) if p4 and p4 != p3
      end
    end
    [team1, team2]
  end

  # Get info for the list of available players,
  # then run different algorithms to get best match.
  def suggestion
    @players = Player.where(id: params[:player_ids])
    suggestions = {}
    approaches = []
    approaches.push(:algo1) # Add new algorithms here.
    approaches.push(:algo2) # These are defined above.
    approaches.each do |algorithm|
      # For each algorithm, run it, passing the players.
      # And then calculate the delta in strengths.
      # Keep these suggestions in a hash.
      team1, team2 = send algorithm, @players
      delta = (team1.strength - team2.strength).abs
      suggestions[delta] = [team1, team2]
    end

    # Get the best suggestion. (smallest delta, found by sorting)
    # TODO: present all the suggestions to the user, instead of just 1.
    # TODO: also generate different combinations for each algorithm.
    best = suggestions.keys.sort[0]
    @team1, @team2 = suggestions[best]
    @max = [@team1.players.to_a.count, @team2.players.to_a.count].max - 1
  end

  # Save game and teams data.
  def accept
    @message = []
    team1 = Team.new(team_params(:team1))
    team2 = Team.new(team_params(:team2))
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
    @game = Game.new(game_params)
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

private

  def team_params(key)
    params.require(key).permit(:name, :score, player_ids: [])
  end

  def game_params
    params.require(:game).permit(:date, :team1id, :team2id, :team1score, :team2score)
  end
end
