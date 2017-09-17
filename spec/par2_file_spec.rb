require "partoo/par2_file"

RSpec.describe Partoo::Par2File do

  describe '#creator' do
    it 'returns the creator' do
      f = Partoo::Par2File.open('spec/fixtures/files/testdata.par2')

      expect(f.creator).to eq 'Created by QuickPar 0.4'
    end
  end

  describe '#read' do
    it 'returns an instance of Partoo::Par2File' do
      io = File.open('spec/fixtures/files/testdata.par2')

      expect(Partoo::Par2File.read(io)).to be_an_instance_of(Partoo::Par2File)
    end
  end

  describe '.open' do
    it 'returns an instance of Partoo::Par2File' do
      expect(Partoo::Par2File.open('spec/fixtures/files/testdata.par2')).to be_an_instance_of(Partoo::Par2File)
    end
  end
end
