require 'hand'

describe Hand do
    subject(:hand) { Hand.new }
    let(:other_hand) { Hand.new }
    let(:symbol_9C) { double('card', :value => 9, :symbol => '9C') }
    let(:symbol_8C) { double('card', :value => 8, :symbol => '8C') }
    let(:symbol_7C) { double('card', :value => 7, :symbol => '7C') }
    let(:symbol_6C) { double('card', :value => 6, :symbol => '6C') }
    let(:symbol_5C) { double('card', :value => 5, :symbol => '5C') }
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
    let(:card_7H)  { double('card', :value => 7,  :suit => :hearts) }
    let(:card_7S)  { double('card', :value => 7,  :suit => :spades) }
    let(:card_6C)  { double('card', :value => 6,  :suit => :clubs) }
    let(:card_6D)  { double('card', :value => 6,  :suit => :diamonds) }
    let(:card_5C)  { double('card', :value => 5,  :suit => :clubs) }
    let(:card_4C)  { double('card', :value => 4,  :suit => :clubs) }
    let(:card_4D)  { double('card', :value => 4,  :suit => :diamonds) }
    let(:card_3C)  { double('card', :value => 3,  :suit => :clubs) }
    let(:card_3D)  { double('card', :value => 3,  :suit => :diamonds) }
    let(:card_2D)  { double('card', :value => 2,  :suit => :diamonds) }
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

    describe '#discard' do
        let(:err_msg) { '10C does not match any cards in your hand' }

        it 'discards the card with the matching symbol from the hand' do
            hand.add_card(symbol_9C)
            hand.add_card(symbol_8C)
            hand.add_card(symbol_7C)
            hand.add_card(symbol_6C)
            hand.add_card(symbol_5C)
            hand.discard('8C')
            expect(hand.cards.length).to eq(4)
            expect(hand.cards.map(&:value)).to eq([9, 7, 6, 5])
        end

        it 'raises an error if the symbol does not match anything in hand' do
            hand.add_card(symbol_9C)
            hand.add_card(symbol_8C)
            hand.add_card(symbol_7C)
            hand.add_card(symbol_6C)
            hand.add_card(symbol_5C)
            expect { hand.discard('10C') }.to raise_error(err_msg)
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

    describe '#compare' do
        it 'returns :win when classification is higher rank than other hand' do
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
            expect(hand.compare(other_hand)).to eq(:win)
        end

        it 'returns :lose when classification is lower rank than other hand' do
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
            expect(hand.compare(other_hand)).to eq(:lose)
        end

        context 'when classification of both hands is straight flush' do
            it 'returns :win when high card is higher than other hand' do
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
                expect(hand.compare(other_hand)).to eq(:win)
            end

            it 'returns :lose when high card is lower than other hand' do
                hand.add_card(card_9C)
                hand.add_card(card_8C)
                hand.add_card(card_7C)
                hand.add_card(card_6C)
                hand.add_card(card_5C)
                other_hand.add_card(card_10D)
                other_hand.add_card(card_9D)
                other_hand.add_card(card_8D)
                other_hand.add_card(card_7D)
                other_hand.add_card(card_6D)
                expect(hand.compare(other_hand)).to eq(:lose)
            end

            it 'returns :tie when the hands differ only by suit' do
                hand.add_card(card_10C)
                hand.add_card(card_9C)
                hand.add_card(card_8C)
                hand.add_card(card_7C)
                hand.add_card(card_6C)
                other_hand.add_card(card_10D)
                other_hand.add_card(card_9D)
                other_hand.add_card(card_8D)
                other_hand.add_card(card_7D)
                other_hand.add_card(card_6D)
                expect(hand.compare(other_hand)).to eq(:tie)
            end
        end

        context 'when classification of both hands is four of a kind' do
            it 'returns :win when value of 4 cards higher than other hand' do
                hand.add_card(card_10C)
                hand.add_card(card_10D)
                hand.add_card(card_10H)
                hand.add_card(card_10S)
                hand.add_card(card_4C)
                other_hand.add_card(card_7C)
                other_hand.add_card(card_7D)
                other_hand.add_card(card_7H)
                other_hand.add_card(card_7S)
                other_hand.add_card(card_5C)
                expect(hand.compare(other_hand)).to eq(:win)
            end
        end

        context 'when classification of both hands is full house' do
            it 'returns :lose when value of 3 cards lower than other hand' do
                hand.add_card(card_7C)
                hand.add_card(card_7D)
                hand.add_card(card_7H)
                hand.add_card(card_9C)
                hand.add_card(card_9D)
                other_hand.add_card(card_10C)
                other_hand.add_card(card_10D)
                other_hand.add_card(card_10H)
                other_hand.add_card(card_8C)
                other_hand.add_card(card_8D)
                expect(hand.compare(other_hand)).to eq(:lose)
            end
        end

        context 'when classification of both hands is flush' do
            it 'returns :win when high card is higher than other hand' do
                hand.add_card(card_JC)
                hand.add_card(card_9C)
                hand.add_card(card_7C)
                hand.add_card(card_5C)
                hand.add_card(card_3C)
                other_hand.add_card(card_10D)
                other_hand.add_card(card_8D)
                other_hand.add_card(card_6D)
                other_hand.add_card(card_4D)
                other_hand.add_card(card_2D)
                expect(hand.compare(other_hand)).to eq(:win)
            end

            it 'returns :lose when high cards tied, second card lower' do
                hand.add_card(card_10C)
                hand.add_card(card_8C)
                hand.add_card(card_7C)
                hand.add_card(card_5C)
                hand.add_card(card_3C)
                other_hand.add_card(card_10D)
                other_hand.add_card(card_9D)
                other_hand.add_card(card_6D)
                other_hand.add_card(card_4D)
                other_hand.add_card(card_2D)
                expect(hand.compare(other_hand)).to eq(:lose)
            end

            it 'returns :win when 2 cards tied, 3rd card higher' do
                hand.add_card(card_10C)
                hand.add_card(card_8C)
                hand.add_card(card_7C)
                hand.add_card(card_5C)
                hand.add_card(card_3C)
                other_hand.add_card(card_10D)
                other_hand.add_card(card_8D)
                other_hand.add_card(card_6D)
                other_hand.add_card(card_4D)
                other_hand.add_card(card_2D)
                expect(hand.compare(other_hand)).to eq(:win)
            end

            it 'returns :lose when 3 cards tied, 4th card lower' do
                hand.add_card(card_10C)
                hand.add_card(card_8C)
                hand.add_card(card_7C)
                hand.add_card(card_5C)
                hand.add_card(card_3C)
                other_hand.add_card(card_10D)
                other_hand.add_card(card_8D)
                other_hand.add_card(card_7D)
                other_hand.add_card(card_6D)
                other_hand.add_card(card_2D)
                expect(hand.compare(other_hand)).to eq(:lose)
            end

            it 'returns :win when 4 cards tied, 5th card higher' do
                hand.add_card(card_10C)
                hand.add_card(card_8C)
                hand.add_card(card_7C)
                hand.add_card(card_4C)
                hand.add_card(card_3C)
                other_hand.add_card(card_10D)
                other_hand.add_card(card_8D)
                other_hand.add_card(card_7D)
                other_hand.add_card(card_4D)
                other_hand.add_card(card_2D)
                expect(hand.compare(other_hand)).to eq(:win)
            end

            it 'returns :tie when the hands differ only by suit' do
                hand.add_card(card_10C)
                hand.add_card(card_8C)
                hand.add_card(card_7C)
                hand.add_card(card_6C)
                hand.add_card(card_4C)
                other_hand.add_card(card_10D)
                other_hand.add_card(card_8D)
                other_hand.add_card(card_7D)
                other_hand.add_card(card_6D)
                other_hand.add_card(card_4D)
                expect(hand.compare(other_hand)).to eq(:tie)
            end
        end

        context 'when classification of both hands is straight' do
            it 'returns :win when high card is higher than other hand' do
                hand.add_card(card_JC)
                hand.add_card(card_10D)
                hand.add_card(card_9C)
                hand.add_card(card_8C)
                hand.add_card(card_7C)
                other_hand.add_card(card_10C)
                other_hand.add_card(card_9D)
                other_hand.add_card(card_8D)
                other_hand.add_card(card_7H)
                other_hand.add_card(card_6C)
                expect(hand.compare(other_hand)).to eq(:win)
            end

            it 'returns :tie when the hands differ only by suit' do
                hand.add_card(card_10D)
                hand.add_card(card_9C)
                hand.add_card(card_8C)
                hand.add_card(card_7C)
                hand.add_card(card_6D)
                other_hand.add_card(card_10C)
                other_hand.add_card(card_9D)
                other_hand.add_card(card_8D)
                other_hand.add_card(card_7H)
                other_hand.add_card(card_6C)
                expect(hand.compare(other_hand)).to eq(:tie)
            end
        end

        context 'when classification of both hands is three of a kind' do
            it 'returns :lose when value of 3 cards lower than other hand' do
                hand.add_card(card_7C)
                hand.add_card(card_7D)
                hand.add_card(card_7H)
                hand.add_card(card_KC)
                hand.add_card(card_JC)
                other_hand.add_card(card_10C)
                other_hand.add_card(card_10D)
                other_hand.add_card(card_10H)
                other_hand.add_card(card_6C)
                other_hand.add_card(card_4C)
                expect(hand.compare(other_hand)).to eq(:lose)
            end
        end

        context 'when classification of both hands is two pairs' do
            it 'returns :win when value of 1st pair higher than other hand' do
                hand.add_card(card_10C)
                hand.add_card(card_10D)
                hand.add_card(card_7C)
                hand.add_card(card_7D)
                hand.add_card(card_4C)
                other_hand.add_card(card_9C)
                other_hand.add_card(card_9D)
                other_hand.add_card(card_8C)
                other_hand.add_card(card_8D)
                other_hand.add_card(card_3C)
                expect(hand.compare(other_hand)).to eq(:win)
            end

            it 'returns :lose when 1st pair tied, value of 2nd pair lower' do
                hand.add_card(card_10C)
                hand.add_card(card_10D)
                hand.add_card(card_7C)
                hand.add_card(card_7D)
                hand.add_card(card_4C)
                other_hand.add_card(card_10H)
                other_hand.add_card(card_10S)
                other_hand.add_card(card_8C)
                other_hand.add_card(card_8D)
                other_hand.add_card(card_3C)
                expect(hand.compare(other_hand)).to eq(:lose)
            end

            it 'returns :win when pairs tied, value of last card higher' do
                hand.add_card(card_10C)
                hand.add_card(card_10D)
                hand.add_card(card_7C)
                hand.add_card(card_7D)
                hand.add_card(card_4C)
                other_hand.add_card(card_10H)
                other_hand.add_card(card_10S)
                other_hand.add_card(card_7H)
                other_hand.add_card(card_7S)
                other_hand.add_card(card_3C)
                expect(hand.compare(other_hand)).to eq(:win)
            end

            it 'returns :tie when the hands differ only by suit' do
                hand.add_card(card_10C)
                hand.add_card(card_10D)
                hand.add_card(card_7C)
                hand.add_card(card_7D)
                hand.add_card(card_4C)
                other_hand.add_card(card_10H)
                other_hand.add_card(card_10S)
                other_hand.add_card(card_7H)
                other_hand.add_card(card_7S)
                other_hand.add_card(card_4D)
                expect(hand.compare(other_hand)).to eq(:tie)
            end
        end

        context 'when classification of both hands is one pair' do
            it 'returns :lose when value of pair lower than other hand' do
                hand.add_card(card_9C)
                hand.add_card(card_9D)
                hand.add_card(card_7C)
                hand.add_card(card_5C)
                hand.add_card(card_3C)
                other_hand.add_card(card_10C)
                other_hand.add_card(card_10D)
                other_hand.add_card(card_6C)
                other_hand.add_card(card_4C)
                other_hand.add_card(card_2H)
                expect(hand.compare(other_hand)).to eq(:lose)
            end

            it 'returns :win when pair tied, value of 1st kicker higher' do
                hand.add_card(card_10H)
                hand.add_card(card_10S)
                hand.add_card(card_7C)
                hand.add_card(card_5C)
                hand.add_card(card_3C)
                other_hand.add_card(card_10C)
                other_hand.add_card(card_10D)
                other_hand.add_card(card_6C)
                other_hand.add_card(card_4C)
                other_hand.add_card(card_2H)
                expect(hand.compare(other_hand)).to eq(:win)
            end

            it 'returns :lose when 3 cards tied, value of 2nd kicker lower' do
                hand.add_card(card_10H)
                hand.add_card(card_10S)
                hand.add_card(card_7C)
                hand.add_card(card_5C)
                hand.add_card(card_3C)
                other_hand.add_card(card_10C)
                other_hand.add_card(card_10D)
                other_hand.add_card(card_7D)
                other_hand.add_card(card_6C)
                other_hand.add_card(card_2H)
                expect(hand.compare(other_hand)).to eq(:lose)
            end

            it 'returns :win when 4 cards tied, value of last card higher' do
                hand.add_card(card_10H)
                hand.add_card(card_10S)
                hand.add_card(card_7C)
                hand.add_card(card_6C)
                hand.add_card(card_3C)
                other_hand.add_card(card_10C)
                other_hand.add_card(card_10D)
                other_hand.add_card(card_7D)
                other_hand.add_card(card_6D)
                other_hand.add_card(card_2H)
                expect(hand.compare(other_hand)).to eq(:win)
            end

            it 'returns :tie when the hands differ only by suit' do
                hand.add_card(card_10H)
                hand.add_card(card_10S)
                hand.add_card(card_7C)
                hand.add_card(card_6C)
                hand.add_card(card_3C)
                other_hand.add_card(card_10C)
                other_hand.add_card(card_10D)
                other_hand.add_card(card_7D)
                other_hand.add_card(card_6D)
                other_hand.add_card(card_3D)
                expect(hand.compare(other_hand)).to eq(:tie)
            end
        end

        context 'when classification of both hands is high card' do
            it 'returns :win when value of 1st card higher than other hand' do
                hand.add_card(card_KC)
                hand.add_card(card_6C)
                hand.add_card(card_4D)
                hand.add_card(card_3C)
                hand.add_card(card_2D)
                other_hand.add_card(card_QC)
                other_hand.add_card(card_6D)
                other_hand.add_card(card_4C)
                other_hand.add_card(card_3D)
                other_hand.add_card(card_2H)
                expect(hand.compare(other_hand)).to eq(:win)
            end

            it 'returns :lose when 1st cards tied, value of 2nd card lower' do
                hand.add_card(card_10H)
                hand.add_card(card_6C)
                hand.add_card(card_4D)
                hand.add_card(card_3C)
                hand.add_card(card_2D)
                other_hand.add_card(card_10S)
                other_hand.add_card(card_9D)
                other_hand.add_card(card_4C)
                other_hand.add_card(card_3D)
                other_hand.add_card(card_2H)
                expect(hand.compare(other_hand)).to eq(:lose)
            end

            it 'returns :win when 2 cards tied, value of 3rd card higher' do
                hand.add_card(card_10H)
                hand.add_card(card_9C)
                hand.add_card(card_8D)
                hand.add_card(card_3C)
                hand.add_card(card_2D)
                other_hand.add_card(card_10S)
                other_hand.add_card(card_9D)
                other_hand.add_card(card_4C)
                other_hand.add_card(card_3D)
                other_hand.add_card(card_2H)
                expect(hand.compare(other_hand)).to eq(:win)
            end

            it 'returns :lose when 3 cards tied, value of 4th card lower' do
                hand.add_card(card_10H)
                hand.add_card(card_9C)
                hand.add_card(card_8D)
                hand.add_card(card_3C)
                hand.add_card(card_2D)
                other_hand.add_card(card_10S)
                other_hand.add_card(card_9D)
                other_hand.add_card(card_8C)
                other_hand.add_card(card_7H)
                other_hand.add_card(card_2H)
                expect(hand.compare(other_hand)).to eq(:lose)
            end

            it 'returns :win when 4 cards tied, value of 5th card higher' do
                hand.add_card(card_10H)
                hand.add_card(card_9C)
                hand.add_card(card_8D)
                hand.add_card(card_7S)
                hand.add_card(card_3C)
                other_hand.add_card(card_10S)
                other_hand.add_card(card_9D)
                other_hand.add_card(card_8C)
                other_hand.add_card(card_7H)
                other_hand.add_card(card_2H)
                expect(hand.compare(other_hand)).to eq(:win)
            end

            it 'returns :tie when the hands differ only by suit' do
                hand.add_card(card_10H)
                hand.add_card(card_9C)
                hand.add_card(card_8D)
                hand.add_card(card_7S)
                hand.add_card(card_3C)
                other_hand.add_card(card_10S)
                other_hand.add_card(card_9D)
                other_hand.add_card(card_8C)
                other_hand.add_card(card_7H)
                other_hand.add_card(card_3D)
                expect(hand.compare(other_hand)).to eq(:tie)
            end
        end
    end
end
