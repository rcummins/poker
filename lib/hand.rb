class Hand
    attr_reader :cards

    def initialize
        @cards = []
    end

    def add_card(card)
        raise 'Maximum of 5 cards allowed per hand' if @cards.length == 5
        
        @cards << card
    end

    def classify_hand
        card_values = group_values
        card_suits = group_suits

        if card_values.values.sort == [1, 4]
            :four_of_a_kind
        elsif card_values.values.sort == [2, 3]
            :full_house
        elsif card_suits.values == [5]
            :flush
        elsif card_values.values.sort == [1, 1, 3]
            :three_of_a_kind
        elsif card_values.values.sort == [1, 2, 2]
            :two_pairs
        elsif card_values.values.sort == [1, 1, 1, 2]
            :one_pair
        end
    end

    private

    def group_values
        card_values = Hash.new(0)

        @cards.each do |card|
            card_values[card.value] += 1
        end

        return card_values
    end

    def group_suits
        card_suits = Hash.new(0)

        @cards.each do |card|
            card_suits[card.suit] += 1
        end

        return card_suits
    end
end
