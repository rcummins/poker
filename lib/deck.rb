require_relative 'card'

class Deck
    attr_reader :cards

    def initialize
        @cards = make_52_cards
    end

    private

    SUITS = [:clubs, :diamonds, :hearts, :spades]

    def make_52_cards
        cards = []

        (1..13).each do |value|
            SUITS.each do |suit|
                cards << Card.new(value, suit)
            end
        end

        return cards
    end
end
