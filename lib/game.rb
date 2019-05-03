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

    private

    def deal_hands
        @deck.shuffle
        5.times do
            @players.each do |player|
                @deck.deal_card(player.hand)
            end
        end
    end

    def look_at_hands
        @players.each do |player|
            eyes_closed_warning(player.name)
            player.print_hand
            press_enter_when_done(player)
        end
        system('clear')
    end

    def ask_bet
    end

    def ask_discard
        @players.each do |player|
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
        @players.each do |player|
            player.print_hand
        end
    end

    def allocate_pot
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
end

if $PROGRAM_NAME == 'game.rb' || $PROGRAM_NAME == 'lib/game.rb'
    game = Game.new
    game.play
end