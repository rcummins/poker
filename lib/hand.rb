class Hand
    attr_reader :cards

    def initialize
        @cards = []
    end

    def add_card(card)
        raise 'Maximum of 5 cards allowed per hand' if @cards.length == 5
        
        @cards << card
    end
end
