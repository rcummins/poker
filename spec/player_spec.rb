require 'player'

describe Player do
    subject(:player1) { Player.new('Renata', 200) }
    subject(:player2) { Player.new('Jen') }
    let(:hand) { double('hand', :class => Hand ) }

    describe '#intialize' do
        it 'gives the player a name' do
            expect(player1.name).to eq('Renata')
        end

        it 'gives the player a pot with a default value of 100' do
            expect(player1.pot).to eq(200)
            expect(player2.pot).to eq(100)
        end

        it 'gives the player a hand of cards' do
            expect(player1.hand).to be_a(Hand)
        end
    end
end
