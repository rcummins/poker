require 'card'

describe Card do
    let(:card_AC) { Card.new(14, :clubs) }
    let(:card_2H) { Card.new(2, :hearts) }
    let(:card_QS) { Card.new(12, :spades) }

    describe '#initialize' do
        it 'sets the value' do
            expect(card_AC.value).to eq(14)
            expect(card_2H.value).to eq(2)
            expect(card_QS.value).to eq(12)
        end

        it 'sets the suit' do
            expect(card_AC.suit).to eq(:clubs)
            expect(card_2H.suit).to eq(:hearts)
            expect(card_QS.suit).to eq(:spades)
        end
    end

    describe '#symbol' do
        it 'returns the correct symbol based on the value and suit' do
            expect(card_AC.symbol).to eq('AC')
            expect(card_2H.symbol).to eq('2H')
            expect(card_QS.symbol).to eq('QS')
        end
    end
end
