require 'rubygems'
require 'active_support'

module ActiveSupport
  module SecureRandom
    ALPHA = ('a'..'z').to_a
    ALPHANUMERICS = ('a'..'z').to_a + ('0'..'9').to_a
    SYLLABLES = ["xy",
                 "ca",
                 "vu",
                 "hi",
                 "pa",
                 "ra",
                 "my",
                 "hy",
                 "qi",
                 "to",
                 "ko",
                 "ne",
                 "we",
                 "fa",
                 "gi",
                 "pi",
                 "so",
                 "ky",
                 "sy",
                 "ce",
                 "do",
                 "dy",
                 "da",
                 "qu",
                 "ge",
                 "vi",
                 "he",
                 "di",
                 "ke",
                 "hu",
                 "ry",
                 "zy",
                 "ve",
                 "ja",
                 "xu",
                 "li",
                 "ci",
                 "ga",
                 "du",
                 "gu",
                 "ru",
                 "vo",
                 "po",
                 "zo",
                 "ba",
                 "ji",
                 "mu",
                 "co",
                 "xi",
                 "ho",
                 "bi",
                 "la",
                 "ta",
                 "be",
                 "cy",
                 "py",
                 "ju",
                 "xe",
                 "pu",
                 "by",
                 "xo",
                 "ly",
                 "wu",
                 "si",
                 "jy",
                 "re",
                 "se",
                 "vy",
                 "nu",
                 "ka",
                 "na",
                 "mo",
                 "sa",
                 "fo",
                 "wo",
                 "fu",
                 "ny",
                 "zu",
                 "ma",
                 "wy",
                 "mi",
                 "de",
                 "qa",
                 "te",
                 "le",
                 "tu",
                 "wa",
                 "ze",
                 "go",
                 "gy",
                 "ti",
                 "no",
                 "jo",
                 "wi",
                 "ku",
                 "fi",
                 "qe",
                 "zi",
                 "lo",
                 "ri",
                 "va",
                 "je",
                 "qy",
                 "pe",
                 "bu",
                 "ro",
                 "fy",
                 "ha",
                 "lu",
                 "ni",
                 "ki",
                 "ty",
                 "me",
                 "qo",
                 "su",
                 "za",
                 "cu",
                 "xa",
                 "bo",
                 "fe"]

    # Returns a random string containing only the characters a..z, the base is 26.
    def self.alpha(length=8)
      random_string(ALPHA, length)
    end

    # Returns a random string containing only the characters a..z and 0..9, the base is 36.
    def self.alphanumeric(length=8)
      random_string(ALPHANUMERICS, length)
    end

    # Returns a random string containing only syllables, the base is 120. Since a syllable has
    # a width of 2 chars, length must always be an even number. Be careful to not making it too
    # short. Though the string is longer, it is better memorizable.
    def self.pronouncable(length=8)
      random_string(SYLLABLES, length / 2)
    end

    # Returns a random string. The parameter 'chars' is an array of characters, the string
    # should consists of. The base is equal to the length of 'chars'.
    def self.random_string(chars, length = 8)
      base = chars.length
      value = ActiveSupport::SecureRandom.random_number(base**length)

      str = []
      (0..base).to_a.reverse.each do |p|
        div = base ** p
        fac = value / div
        value = value % div
        str << chars[fac] if (str.length > 0) or (fac > 0)
      end

      # "Vornullen"
      chars[0]*(length-str.length) +  str.join
    end

    # Returns the number of possible strings. You can either provide the base or the 'chars'-array.
    # So you can find out, how likely it is, that a string can be (brute forced) guessed. 'char_width'
    # must be set to 2, if you have syllables.
    def self.random_strings(chars_or_base, length = 8, char_width = 1)
      base = chars_or_base.is_a?(Array) ? chars_or_base.length : chars_or_base
      base ** (length / char_width)
    end

  end
end
