require_relative '../lib/hangman.rb'

describe Hangman do
  subject { Hangman.new }

  describe '#options' do
    it 'understands the one-letter case' do
      expect(subject.options('_','a')).to eq %w(_ a)
    end

    it 'understands the two-letter case' do
      expect(subject.options('__','a')).to eq %w(__ a_ _a)
    end

    it 'understands the three-letter case' do
      expect(subject.options('___','a')).to eq %w(___ a__ _a_ __a)
      expect(subject.options('_c_','a')).to eq %w(_c_ ac_ _ca)
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
      end

      it 'excludes missing letters' do
        expect(subject.filter_words(list,'a__',[])).to eq %w(abc)
        expect(subject.filter_words(list,'___',['e'])).to eq %w(abc ghi)
      end
    end
  end
end
