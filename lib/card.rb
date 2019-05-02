class Card
    attr_reader :value, :suit

    def initialize(value, suit)
        @value = value
        @suit = suit
    end

    def symbol
        VALUE_SYMBOLS[@value] + SUIT_SYMBOLS[@suit]
    end

    private

    VALUE_SYMBOLS = {
        2 => '2',
        3 => '3',
        4 => '4',
        5 => '5',
        6 => '6',
        7 => '7',
        8 => '8',
        9 => '9',
        10 => '10',
        11 => 'J',
        12 => 'Q',
        13 => 'K',
        14 => 'A'
    }

    SUIT_SYMBOLS = {
        clubs: 'C',
        diamonds: 'D',
        hearts: 'H',
        spades: 'S'
    }
end
