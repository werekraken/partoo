require "partoo/crc32"

RSpec.describe Partoo::CRC32 do

  describe '#finish' do
    it 'packs the crc' do
      contents = "this\n"
      crc = Partoo::CRC32.new
      crc.update(contents)
      zcrc = Zlib.crc32(contents).to_s(16).rjust(8, '0')

      expect(Digest.hexencode(crc.finish)).to eq zcrc
    end
  end

  describe '#reset' do
    it 'reinitializes the crc' do
      fresh_crc = Partoo::CRC32.new
      reset_crc = Partoo::CRC32.new
      reset_crc.update("this\n")
      reset_crc.reset

      expect(reset_crc).to eq fresh_crc
    end
  end

  describe '#update' do
    it 'calculates crc of supplied data' do
      contents = "this\n"
      crc = Partoo::CRC32.new
      crc.update(contents)
      zcrc = Zlib.crc32(contents).to_s(16).rjust(8, '0')

      expect(crc.hexdigest).to eq zcrc
    end

    it 'adds to previous checksum' do
      contentsA = "this\n"
      contentsB = "that\n"
      crc = Partoo::CRC32.new
      crc.update(contentsA)
      crc.update(contentsB)
      zcrc = Zlib.crc32(contentsA.concat(contentsB)).to_s(16).rjust(8, '0')

      expect(crc.hexdigest).to eq zcrc
    end
  end

  describe '.crc32_trim_trailing' do
    it 'returns crcA when given crcAB, crcB, and lengthB.' do
      contentsA = "this\n"
      contentsB = "that\n"
      crcA = Zlib.crc32(contentsA)
      crcB = Zlib.crc32(contentsB)
      crcAB = Zlib.crc32(contentsA.concat(contentsB))
      lenB = contentsB.length

      expect(Partoo::CRC32.crc32_trim_trailing(crcAB, crcB, lenB)).to eq crcA
    end
  end
end
