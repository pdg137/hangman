require_relative '../lib/hangman.rb'

describe Hangman do
  subject { Hangman.new }

  describe '#options' do
    it 'understands the one-letter case' do
      expect(subject.get_options(%w(a b),'_','a')).to eq %w(_ a)
    end

    it 'leaves out impossible options' do
      expect(subject.get_options(%w(b),'_','a')).to eq %w(_)
    end

    it 'understands the two-letter case' do
      expect(subject.get_options(%w(ab ba bb),'__','a')).to eq %w(__ _a a_)
      expect(subject.get_options(%w(aa ba bb),'__','a')).to eq %w(__ _a aa)
      expect(subject.get_options(%w(ba bc bv),'b_','a')).to eq %w(b_ ba)
    end
  end

  describe '#filter_words' do
    context 'given an empty list' do
      let(:list) { [] }

      it 'returns an empty list' do
        expect(subject.filter_words(list,'',[])).to be_empty
      end
    end

    context 'given abc, def, ghi' do
      let(:list) { %w(abc def ghi) }

      it 'matches correctly' do
        expect(subject.filter_words(list,'a__',[])).to eq %w(abc)
        expect(subject.filter_words(list,'_b_',[])).to eq %w(abc)
        expect(subject.filter_words(list,'_',[])).to be_empty
      end

      it 'excludes missing letters' do
        expect(subject.filter_words(list,'a__',[])).to eq %w(abc)
        expect(subject.filter_words(list,'___',['e'])).to eq %w(abc ghi)
      end
    end
  end
end
