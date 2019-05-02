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
        card_value_counts = group_values
        card_suit_counts = group_suits
        card_value_diffs = calculate_card_value_diffs

        case
        when card_suit_counts.values == [5] && card_value_diffs == [1,1,1,1]
            :straight_flush
        when card_value_counts.values.sort == [1, 4]
            :four_of_a_kind
        when card_value_counts.values.sort == [2, 3]
            :full_house
        when card_suit_counts.values == [5]
            :flush
        when card_value_diffs == [1, 1, 1, 1]
            :straight
        when card_value_counts.values.sort == [1, 1, 3]
            :three_of_a_kind
        when card_value_counts.values.sort == [1, 2, 2]
            :two_pairs
        when card_value_counts.values.sort == [1, 1, 1, 2]
            :one_pair
        else
            :high_card
        end
    end

    def beats?(other_hand)
        this_hand_rank = HAND_CLASSIFICATION_RANKS[self.classify_hand]
        other_hand_rank = HAND_CLASSIFICATION_RANKS[other_hand.classify_hand]

        return true if this_hand_rank > other_hand_rank
        return false if this_hand_rank < other_hand_rank
    end

    private

    HAND_CLASSIFICATION_RANKS = {
        straight_flush: 9,
        four_of_a_kind: 8,
        full_house: 7,
        flush: 6,
        straight: 5,
        three_of_a_kind: 4,
        two_pairs: 3,
        one_pair: 2,
        high_card: 1
    }

    def group_values
        card_value_counts = Hash.new(0)

        @cards.each { |card| card_value_counts[card.value] += 1 }

        return card_value_counts
    end

    def group_suits
        card_suit_counts = Hash.new(0)

        @cards.each { |card| card_suit_counts[card.suit] += 1 }

        return card_suit_counts
    end

    def calculate_card_value_diffs
        values_high_ace = @cards.map(&:value).sort

        values_low_ace = values_high_ace.map do |original_value|
            original_value == 14 ? 1 : original_value
        end.sort

        diffs_high_ace = []
        diffs_low_ace = []

        (0...4).each do |ind|
            diffs_high_ace << values_high_ace[ind + 1] - values_high_ace[ind]
            diffs_low_ace  << values_low_ace[ind + 1]  - values_low_ace[ind]
        end

        if diffs_low_ace == [1, 1, 1, 1]
            return diffs_low_ace
        else
            return diffs_high_ace
        end
    end
end
