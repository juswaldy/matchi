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
  # break up the list into 2 player slices and assign
  # to each team.
  def suggestion
    @present = Player.find_all_by_id(params[:player_ids])
    @team1 = Team.new
    @team2 = Team.new
    @present.sort_by{|x| [-x.strength, x.nickname]}.each_slice(2) do |player, nextplayer|
      if @team1.potential > @team2.potential
        assign(@team2, player)
        assign(@team1, nextplayer) if nextplayer
      else
        assign(@team1, player)
	assign(@team2, nextplayer) if nextplayer
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
