require_relative 'deck'
require_relative 'player'

class Game
    def initialize
        @deck = Deck.new
        @players = [Player.new('Renata'), Player.new('Jen')]
        @turn_index = 0
    end

    def play
        deal_hands
        look_at_hands
        ask_bet
        ask_discard
        ask_bet
        reveal_hands
        allocate_pot
    end

    def deal_hands
    end

    def look_at_hands
    end

    def ask_bet
    end

    def ask_discard
        @players.each do |player|
            eyes_closed_warning(player.name)
            player.print_hand
            player.ask_discard
        end
    end

    def reveal_hands
    end

    def allocate_pot
    end

    private

    def eyes_closed_warning(name)
        warning_string =  "#{name}'s turn to look at their hand. "
        warning_string += "Everyone else, close your eyes! "
        puts warning_string
        puts "#{name}, press enter when you're ready."
        gets
    end
end

if $PROGRAM_NAME == 'game.rb' || $PROGRAM_NAME == 'lib/game.rb'
    game = Game.new
    game.play
end