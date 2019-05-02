require 'hand'

describe Hand do
    subject(:hand) { Hand.new }
    let(:other_hand) { Hand.new }
    let(:card_AS)  { double('card', :value => 14, :suit => :spades) }
    let(:card_KC)  { double('card', :value => 13, :suit => :clubs) }
    let(:card_QC)  { double('card', :value => 12, :suit => :clubs) }
    let(:card_JC)  { double('card', :value => 11, :suit => :clubs) }
    let(:card_10C) { double('card', :value => 10, :suit => :clubs) }
    let(:card_10D) { double('card', :value => 10, :suit => :diamonds) }
    let(:card_10H) { double('card', :value => 10, :suit => :hearts) }
    let(:card_10S) { double('card', :value => 10, :suit => :spades) }
    let(:card_9C)  { double('card', :value => 9,  :suit => :clubs) }
    let(:card_9D)  { double('card', :value => 9,  :suit => :diamonds) }
    let(:card_8C)  { double('card', :value => 8,  :suit => :clubs) }
    let(:card_8D)  { double('card', :value => 8,  :suit => :diamonds) }
    let(:card_7C)  { double('card', :value => 7,  :suit => :clubs) }
    let(:card_7D)  { double('card', :value => 7,  :suit => :diamonds) }
    let(:card_6C)  { double('card', :value => 6,  :suit => :clubs) }
    let(:card_6D)  { double('card', :value => 6,  :suit => :diamonds) }
    let(:card_5C)  { double('card', :value => 5,  :suit => :clubs) }
    let(:card_4C)  { double('card', :value => 4,  :suit => :clubs) }
    let(:card_3D)  { double('card', :value => 3,  :suit => :diamonds) }
    let(:card_2H)  { double('card', :value => 2,  :suit => :hearts) }

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

    describe '#classify_hand' do
        it 'recognizes a hand with a straight flush' do
            hand.add_card(card_9C)
            hand.add_card(card_8C)
            hand.add_card(card_7C)
            hand.add_card(card_6C)
            hand.add_card(card_5C)
            expect(hand.classify_hand).to eq(:straight_flush)
        end

        it 'recognizes a hand with four of a kind' do
            hand.add_card(card_10C)
            hand.add_card(card_10D)
            hand.add_card(card_10H)
            hand.add_card(card_10S)
            hand.add_card(card_4C)
            expect(hand.classify_hand).to eq(:four_of_a_kind)
        end

        it 'recognizes a hand with a full house' do
            hand.add_card(card_10C)
            hand.add_card(card_10D)
            hand.add_card(card_10H)
            hand.add_card(card_7C)
            hand.add_card(card_7D)
            expect(hand.classify_hand).to eq(:full_house)
        end

        it 'recognizes a hand with a flush' do
            hand.add_card(card_QC)
            hand.add_card(card_JC)
            hand.add_card(card_8C)
            hand.add_card(card_6C)
            hand.add_card(card_4C)
            expect(hand.classify_hand).to eq(:flush)
        end

        it 'recognizes a hand with a straight without an ace' do
            hand.add_card(card_JC)
            hand.add_card(card_10D)
            hand.add_card(card_9C)
            hand.add_card(card_8C)
            hand.add_card(card_7C)
            expect(hand.classify_hand).to eq(:straight)
        end

        it 'recognizes a hand with a straight with a high ace' do
            hand.add_card(card_AS)
            hand.add_card(card_KC)
            hand.add_card(card_QC)
            hand.add_card(card_JC)
            hand.add_card(card_10D)
            expect(hand.classify_hand).to eq(:straight)
        end

        it 'recognizes a hand with a straight with a low ace' do
            hand.add_card(card_5C)
            hand.add_card(card_4C)
            hand.add_card(card_3D)
            hand.add_card(card_2H)
            hand.add_card(card_AS)
            expect(hand.classify_hand).to eq(:straight)
        end

        it 'recognizes a hand with three of a kind' do
            hand.add_card(card_10C)
            hand.add_card(card_10D)
            hand.add_card(card_10H)
            hand.add_card(card_7C)
            hand.add_card(card_4C)
            expect(hand.classify_hand).to eq(:three_of_a_kind)
        end

        it 'recognizes a hand with two pairs' do
            hand.add_card(card_10C)
            hand.add_card(card_10D)
            hand.add_card(card_7C)
            hand.add_card(card_7D)
            hand.add_card(card_4C)
            expect(hand.classify_hand).to eq(:two_pairs)
        end

        it 'recognizes a hand with one pair' do
            hand.add_card(card_10C)
            hand.add_card(card_10D)
            hand.add_card(card_8C)
            hand.add_card(card_7C)
            hand.add_card(card_4C)
            expect(hand.classify_hand).to eq(:one_pair)
        end

        it 'recognizes a hand with nothing (high card)' do
            hand.add_card(card_QC)
            hand.add_card(card_10D)
            hand.add_card(card_8C)
            hand.add_card(card_4C)
            hand.add_card(card_3D)
            expect(hand.classify_hand).to eq(:high_card)
        end

        it 'does not classify Q-K-A-2-3 as a straight' do
            hand.add_card(card_QC)
            hand.add_card(card_KC)
            hand.add_card(card_AS)
            hand.add_card(card_2H)
            hand.add_card(card_3D)
            expect(hand.classify_hand).to eq(:high_card)
        end
    end

    describe '#beats?' do
        it 'returns true when classification of other hand is lower rank' do
            hand.add_card(card_9C)
            hand.add_card(card_8C)
            hand.add_card(card_7C)
            hand.add_card(card_6C)
            hand.add_card(card_5C)
            other_hand.add_card(card_10C)
            other_hand.add_card(card_10D)
            other_hand.add_card(card_10H)
            other_hand.add_card(card_10S)
            other_hand.add_card(card_4C)
            expect(hand.beats?(other_hand)).to be true
        end

        it 'returns false when classification of other hand is higher rank' do
            hand.add_card(card_QC)
            hand.add_card(card_JC)
            hand.add_card(card_8C)
            hand.add_card(card_6C)
            hand.add_card(card_4C)
            other_hand.add_card(card_10C)
            other_hand.add_card(card_10D)
            other_hand.add_card(card_10H)
            other_hand.add_card(card_7C)
            other_hand.add_card(card_7D)
            expect(hand.beats?(other_hand)).to be false
        end

        context 'when classification of both hands is the same' do
            xit 'returns true when straight flush high card is higher' do
                hand.add_card(card_10D)
                hand.add_card(card_9D)
                hand.add_card(card_8D)
                hand.add_card(card_7D)
                hand.add_card(card_6D)
                other_hand.add_card(card_9C)
                other_hand.add_card(card_8C)
                other_hand.add_card(card_7C)
                other_hand.add_card(card_6C)
                other_hand.add_card(card_5C)
                expect(hand.beats?(other_hand)).to be true
            end
        end
    end
end
