require_relative 'hand'

class Player
    attr_reader :name, :pot, :hand

    def initialize(name, pot = 100)
        @name = name
        @pot = pot
        @hand = Hand.new
    end

    def print_hand
        puts "#{@name}'s hand: #{@hand.format_for_printing}"
    end

    def ask_discard
        begin
            puts "Example: 'AC,2H' = discard ace of clubs and 2 of hearts"
            print "#{@name}, enter symbols of 1-3 cards to discard, or 'none': "
            user_entry = gets.chomp
            symbols = parse_cards_to_discard(user_entry)

            raise 'you entered more than 3 symbols' if symbols.length > 3

            symbols.each do |symbol|
                @hand.discard(symbol)
            end

            return symbols.length
        rescue => error
            puts "Sorry, #{error.message}. Please try again."
            retry
        end
    end

    def take_from_pot(amount)
        raise "you don't have enough money in your pot" if amount > @pot
        @pot -= amount
    end

    def add_to_pot(amount)
        @pot += amount
    end

    private

    def parse_cards_to_discard(user_entry)
        return [] if user_entry.downcase == 'none'
        return user_entry.upcase.split(',')
    end
end
