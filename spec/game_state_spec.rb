require_relative '../lib/game_state.rb'

describe 'GameState#moves' do
  let(:moves) { subject.moves }

  context 'one-letter' do
    subject { GameState.new(%w(a b), '_', [], 'a', :computer) }

    specify do
      expect(moves.map(&:pattern).sort).to eq %w(_ a)
    end
  end

  context 'guessing a when the only word is b' do
    subject { GameState.new(%w(b), '_', [], 'a', :computer) }

    specify do
      expect(moves.map(&:pattern).sort).to eq %w(_)
    end
  end

  context 'two-letter words 1' do
    subject { GameState.new(%w(ab ba bb), '__', [], 'a', :computer) }

    specify do
      expect(moves.map(&:pattern).sort).to eq %w(__ _a a_)
    end
  end

  context 'two-letter words 2' do
    subject { GameState.new(%w(aa ba bb), '__', [], 'a', :computer) }

    specify do
      expect(moves.map(&:pattern).sort).to eq %w(__ _a aa)
    end
  end

  context 'two-letter words 3' do
    subject { GameState.new(%w(ba bc bv), 'b_', [], 'a', :computer) }

    specify do
      expect(moves.map(&:pattern).sort).to eq %w(b_ ba)
    end
  end

end
