require_relative '../lib/hangman.rb'

describe Hangman do
  subject { Hangman.new }

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
