require_relative 'card'

class Deck
    attr_reader :cards

    def initialize
        @cards = make_52_cards
    end

    def shuffle
        @cards.shuffle!
    end

    def deal_card(hand)
        card = @cards.shift
        hand.add_card(card)
    end

    private

    SUITS = [:clubs, :diamonds, :hearts, :spades]

    def make_52_cards
        cards = []

        (2..14).each do |value|
            SUITS.each do |suit|
                cards << Card.new(value, suit)
            end
        end

        return cards
    end
end
