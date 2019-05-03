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

    def compare(other_hand)
        this_hand_class = self.classify_hand
        other_hand_class = other_hand.classify_hand

        this_hand_rank = HAND_CLASSIFICATION_RANKS[this_hand_class]
        other_hand_rank = HAND_CLASSIFICATION_RANKS[other_hand_class]

        return :win if this_hand_rank > other_hand_rank
        return :lose if this_hand_rank < other_hand_rank

        # if classifications are the same, look at the card values
        case this_hand_class
        when :straight_flush, :straight
            return :win if self.card_values.max > other_hand.card_values.max
            return :lose if self.card_values.max < other_hand.card_values.max
            return :tie
        when :four_of_a_kind
            this_hand_value = self.find_X_of_a_kind_values(4).first
            other_hand_value = other_hand.find_X_of_a_kind_values(4).first
            return :win if this_hand_value > other_hand_value
            return :lose
        when :full_house, :three_of_a_kind
            this_hand_value = self.find_X_of_a_kind_values(3).first
            other_hand_value = other_hand.find_X_of_a_kind_values(3).first
            return :win if this_hand_value > other_hand_value
            return :lose
        when :flush, :high_card
            this_hand_values = self.card_values.sort.reverse
            other_hand_values = other_hand.card_values.sort.reverse
            (0..4).each do |ind|
                return :win if this_hand_values[ind] > other_hand_values[ind]
                return :lose if this_hand_values[ind] < other_hand_values[ind]
            end
            return :tie
        when :two_pairs
            this_hand_pairs = self.find_X_of_a_kind_values(2)
            other_hand_pairs = other_hand.find_X_of_a_kind_values(2)
            (0..1).each do |ind|
                return :win if this_hand_pairs[ind] > other_hand_pairs[ind]
                return :lose if this_hand_pairs[ind] < other_hand_pairs[ind]
            end
            this_hand_kicker = self.find_X_of_a_kind_values(1).first
            other_hand_kicker = other_hand.find_X_of_a_kind_values(1).first
            return :win if this_hand_kicker > other_hand_kicker
            return :lose if this_hand_kicker < other_hand_kicker
            return :tie
        when :one_pair
            this_hand_pair_value = self.find_X_of_a_kind_values(2).first
            other_hand_pair_value = other_hand.find_X_of_a_kind_values(2).first
            return :win if this_hand_pair_value > other_hand_pair_value
            return :lose if this_hand_pair_value < other_hand_pair_value
            this_hand_kickers = self.find_X_of_a_kind_values(1)
            other_hand_kickers = other_hand.find_X_of_a_kind_values(1)
            (0..2).each do |i|
                return :win if this_hand_kickers[i] > other_hand_kickers[i]
                return :lose if this_hand_kickers[i] < other_hand_kickers[i]
            end
            return :tie
        end
    end

    protected

    def card_values
        @cards.map(&:value)
    end

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
        values_high_ace = card_values.sort

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

    def find_X_of_a_kind_values(number_in_group)
        selected_counts = group_values.select do |card_value, count_of_cards|
            count_of_cards == number_in_group
        end

        return selected_counts.keys.sort.reverse
    end
end
