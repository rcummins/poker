require 'game'

describe Game do
    let(:card_JC)  { double('card', :value => 11, :suit => :clubs) }
    let(:card_10C) { double('card', :value => 10, :suit => :clubs) }
    let(:card_9C)  { double('card', :value => 9,  :suit => :clubs) }
    let(:card_8C)  { double('card', :value => 8,  :suit => :clubs) }
    let(:card_7C)  { double('card', :value => 7,  :suit => :clubs) }
    let(:card_3C)  { double('card', :value => 3,  :suit => :clubs) }
    let(:card_10D) { double('card', :value => 10, :suit => :diamonds) }
    let(:card_9D)  { double('card', :value => 9,  :suit => :diamonds) }
    let(:card_8D)  { double('card', :value => 8,  :suit => :diamonds) }
    let(:card_7D)  { double('card', :value => 7,  :suit => :diamonds) }
    let(:card_3D)  { double('card', :value => 3,  :suit => :diamonds) }
    let(:card_8H)  { double('card', :value => 8,  :suit => :hearts) }
    let(:card_7H)  { double('card', :value => 7,  :suit => :hearts) }
    let(:card_6H)  { double('card', :value => 6,  :suit => :hearts) }
    let(:card_5H)  { double('card', :value => 5,  :suit => :hearts) }
    let(:card_3H)  { double('card', :value => 3,  :suit => :hearts) }
    let(:card_8S)  { double('card', :value => 8,  :suit => :spades) }
    let(:card_7S)  { double('card', :value => 7,  :suit => :spades) }
    let(:card_6S)  { double('card', :value => 6,  :suit => :spades) }
    let(:card_5S)  { double('card', :value => 5,  :suit => :spades) }
    let(:card_3S)  { double('card', :value => 3,  :suit => :spades) }
    let(:hand1) { Hand.new }
    let(:hand2) { Hand.new }
    let(:hand3) { Hand.new }
    let(:hand4) { Hand.new }
    let(:player1) { double('player1', :hand => hand1)}
    let(:player2) { double('player2', :hand => hand2)}
    let(:player3) { double('player3', :hand => hand3)}
    let(:player4) { double('player4', :hand => hand4)}
    subject(:game_12) { Game.new(player1, player2) }
    subject(:game_1234) { Game.new(player1, player2, player3, player4) }

    describe '#determine_round_winners' do
        it 'returns the winning player' do
            hand1.add_card(card_JC)
            hand1.add_card(card_9C)
            hand1.add_card(card_8C)
            hand1.add_card(card_7C)
            hand1.add_card(card_3C)
            hand2.add_card(card_10D)
            hand2.add_card(card_9D)
            hand2.add_card(card_8D)
            hand2.add_card(card_7D)
            hand2.add_card(card_3D)
            expect(game_12.determine_round_winners).to eq([player1])
        end

        it 'returns two players in case of a two-way tie' do
            hand1.add_card(card_10C)
            hand1.add_card(card_9C)
            hand1.add_card(card_8C)
            hand1.add_card(card_7C)
            hand1.add_card(card_3C)
            hand2.add_card(card_10D)
            hand2.add_card(card_9D)
            hand2.add_card(card_8D)
            hand2.add_card(card_7D)
            hand2.add_card(card_3D)
            expect(game_12.determine_round_winners).to eq([player1,player2])
        end

        it 'returns two players in case of two unequal two-way ties' do
            hand1.add_card(card_8H)
            hand1.add_card(card_7H)
            hand1.add_card(card_6H)
            hand1.add_card(card_5H)
            hand1.add_card(card_3H)
            hand2.add_card(card_8S)
            hand2.add_card(card_7S)
            hand2.add_card(card_6S)
            hand2.add_card(card_5S)
            hand2.add_card(card_3S)
            hand3.add_card(card_10C)
            hand3.add_card(card_9C)
            hand3.add_card(card_8C)
            hand3.add_card(card_7C)
            hand3.add_card(card_3C)
            hand4.add_card(card_10D)
            hand4.add_card(card_9D)
            hand4.add_card(card_8D)
            hand4.add_card(card_7D)
            hand4.add_card(card_3D)
            expect(game_1234.determine_round_winners).to eq([player3,player4])
        end
    end
end