module Partoo
  module CRC32

    GF2_DIM = 32;

    def self.crc32_trim_trailing(crc1, crc2, len2)

      even = Array.new(32, 0) # even-power-of-two zeros operator
      odd  = Array.new(32, 0) # odd-power-of-two zeros operator

      # degenerate case (also disallow negative lengths)
      return crc1 if len2 <= 0

      # get crcA0
      crc1 ^= crc2

      # put operator for one zero bit in odd
      odd[0] = 0xdb710641 # CRC-32 trim polynomial
      row = 0x80000000
      n = 1
      while n < GF2_DIM
        odd[n] = row
        row >>= 1
        n += 1
      end

      # put operator for two zero bits in even
      gf2_matrix_square_trim(even, odd)

      # put operator for four zero bits in odd
      gf2_matrix_square_trim(odd, even)

      # remove len2 zeros from crc1 (first square will put the operator for one
      # zero byte, eight zero bits, in even)
      loop do
        # apply zeros operator for this bit of len2
        gf2_matrix_square_trim(even, odd)

        crc1 = gf2_matrix_times_trim(even, crc1) if len2 & 1
        len2 >>= 1

        # if no more bits set, then done
        break if len2 == 0

        # another iteration of the loop with odd and even swapped
        gf2_matrix_square_trim(odd, even)

        crc1 = gf2_matrix_times_trim(odd, crc1) if len2 & 1
        len2 >>= 1

        # if no more bits set, then done
        break if len2 == 0
      end

      crc1
    end

    def self.gf2_matrix_square_trim(square, mat)
      n = 0
      while n < GF2_DIM
        square[n] = gf2_matrix_times_trim(mat, mat[n])
        n += 1
      end
    end

    def self.gf2_matrix_times_trim(mat, vec)
      n = 0
      sum = 0
      while vec > 0
        sum ^= mat[n] if vec & 0x80000000 != 0
        vec = (vec << 1) & 0xffffffff
        n += 1
      end
      sum
    end
  end
end
