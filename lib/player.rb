class Player
    attr_reader :name, :pot, :hand

    def initialize(name, pot = 100)
        @name = name
        @pot = pot
        @hand = Hand.new
    end
end
