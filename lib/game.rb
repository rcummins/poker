require_relative 'deck'
require_relative 'player'

class Game
    def initialize(*test_players)
        @deck = Deck.new
        @pot = 0
        if test_players.empty?
            @players = get_player_names.map { |name| Player.new(name) }
        else
            @players = test_players
        end
        @active_players = @players.dup
    end

    def play
        until game_won?
            play_round
        end
        puts "Congrats, #{@active_players.first.name}! You win the game!"
    end

    def determine_round_winners
        winners = @active_players.dup

        @active_players.each do |other_player|
            winners.delete_if do |winner|
                winner != other_player &&
                winner.hand.compare(other_player.hand) == :lose
            end
        end

        return winners
    end

    private

    def play_round
        deal_hands
        look_at_hands
        ask_bet
        ask_discard
        ask_bet
        reveal_hands
        allocate_pot
        determine_eligible_players
    end

    def get_player_names
        player_names = []
        response = ''

        until response == 'none'
            print "Enter player name, or 'none' for no more players: "
            response = gets.chomp
            player_names << response unless response.downcase == 'none'
        end

        return player_names
    end

    def deal_hands
        @deck.shuffle
        5.times do
            @active_players.each do |player|
                @deck.deal_card(player.hand)
            end
        end
    end

    def look_at_hands
        @active_players.each do |player|
            eyes_closed_warning(player.name)
            player.print_hand
            press_enter_when_done(player)
        end
        system('clear')
    end

    def ask_bet
        print_pot_balances
        @active_players.each do |player|
            begin
                print "#{player.name}, enter the amount to bet (or 'fold'): "
                response = gets.chomp.downcase
                next if response == 'fold'

                amount = response.to_f
                player.take_from_pot(amount)
                @pot += amount
            rescue => error
                puts "Sorry, #{error.message}. Please try again or fold."
                retry
            end
        end
    end

    def ask_discard
        @active_players.each do |player|
            eyes_closed_warning(player.name)
            player.print_hand
            number_of_cards_discarded = player.ask_discard
            number_of_cards_discarded.times { @deck.deal_card(player.hand) }
            player.print_hand
            press_enter_when_done(player)
        end
        system('clear')
    end

    def reveal_hands
        @active_players.each do |player|
            player.print_hand
        end
    end

    def allocate_pot
        winners = determine_round_winners
        announce_round_winners(winners)
        winners.each do |winner|
            winner.add_to_pot(@pot / winners.length)
        end
        print_pot_balances
    end

    def determine_eligible_players
        @active_players = @players.dup
        @active_players.delete_if { |player| player.pot == 0 }
    end

    def game_won?
        determine_eligible_players
        return @active_players.length == 1
    end

    def eyes_closed_warning(name)
        system('clear')
        warning_string =  "#{name}'s turn to look at their hand. "
        warning_string += "Everyone else, close your eyes! "
        puts warning_string
        puts "#{name}, press enter when you're ready."
        gets
    end

    def press_enter_when_done(player)
        puts "#{player.name}, press enter when you're done."
        gets
    end

    def announce_round_winners(winners)
        if winners.length == 1
            puts "#{winners.first.name} wins! They get the whole pot."
        else
            name_string = winners.map { |winner| winner.name }.join(' and ')
            puts "#{name_string} tie for the win! They split the pot."
        end
    end

    def print_pot_balances
        @active_players.each do |player|
            puts "#{player.name}'s pot balance: $#{player.pot}"
        end
    end
end

if $PROGRAM_NAME == 'game.rb' || $PROGRAM_NAME == 'lib/game.rb'
    game = Game.new
    game.play
end