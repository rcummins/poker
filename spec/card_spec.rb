require 'card'

describe Card do
    let(:card_AC) { Card.new(1, :clubs) }
    let(:card_2H) { Card.new(2, :hearts) }
    let(:card_QS) { Card.new(12, :spades) }

    describe '#initialize' do
        it 'sets the value' do
            expect(card_AC.value).to eq(1)
            expect(card_2H.value).to eq(2)
            expect(card_QS.value).to eq(12)
        end

        it 'sets the suit' do
            expect(card_AC.suit).to eq(:clubs)
            expect(card_2H.suit).to eq(:hearts)
            expect(card_QS.suit).to eq(:spades)
        end
    end
end
