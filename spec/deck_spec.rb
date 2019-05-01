require 'deck'

describe Deck do
    subject(:deck) { Deck.new }

    describe '#initialize' do
        it 'fills @cards with 52 unique cards' do
            expect(deck.cards.length).to eq(52)
            uniq_symbols = deck.cards.map(&:symbol).uniq
            expect(uniq_symbols.length).to eq(52)
        end
    end
end
