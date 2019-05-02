require 'hand'

describe Hand do
    subject(:hand) { Hand.new }

    describe '#initialize' do
        it 'sets @cards to an empty string' do
            expect(hand.cards).to eq([])
        end
    end

    describe '#add_card' do
        let(:card) { double("card") }
        let(:err_msg) { 'Maximum of 5 cards allowed per hand' }

        it 'adds a card to the hand' do
            hand.add_card(card)
            expect(hand.cards).to eq([card])
            hand.add_card(card)
            expect(hand.cards).to eq([card, card])
        end

        it 'raises an error if the hand already has 5 cards' do
            5.times { hand.add_card(card) }
            expect { hand.add_card(card) }.to raise_error(err_msg)
        end
    end
end