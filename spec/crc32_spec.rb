require "partoo/crc32"

RSpec.describe Partoo::CRC32 do
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
