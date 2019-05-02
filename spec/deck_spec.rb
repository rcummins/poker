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

    describe '#shuffle' do
        it 'changes the order of the cards in the deck' do
            cards_before_shuffling = deck.cards.dup
            deck.shuffle
            expect(deck.cards).not_to eq(cards_before_shuffling)
            expect(deck.cards).to match_array(cards_before_shuffling)
        end

        it 'does not change the number of cards in the deck' do
            deck.shuffle
            expect(deck.cards.length).to eq(52)
        end
    end

    describe '#deal_card' do
        it 'removes the first card from the deck' do
            expect(deck.cards.first.symbol).to eq('AC')
            deck.deal_card
            expect(deck.cards.first.symbol).to eq('AD')
            expect(deck.cards.length).to eq(51)
        end

        it 'returns the first card from the deck' do
            expect(deck.deal_card.symbol).to eq('AC')
        end
    end
end
