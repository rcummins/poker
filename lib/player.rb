require_relative 'hand'

class Player
    attr_reader :name, :pot, :hand

    def initialize(name, pot = 100)
        @name = name
        @pot = pot
        @hand = Hand.new
    end

    def ask_discard
        begin
            puts "Example: 'AC,2H' = discard ace of clubs and 2 of hearts"
            puts "#{@name}, enter symbols of 1-3 cards to discard, or 'none': "
            user_entry = gets.chomp
            symbols = parse_cards_to_discard(user_entry)

            raise 'you entered more than 3 symbols' if symbols.length > 3

            symbols.each do |symbol|
                @hand.discard(symbol)
            end
        rescue => error
            puts "Sorry, #{error.message}. Please try again."
            retry
        end
    end

    private

    def parse_cards_to_discard(user_entry)
        return [] if user_entry.downcase == 'none'
        return user_entry.upcase.split(',')
    end
end
