extension ISO_7064.MOD_97_10 {

    /// The remainder on division by 97 of the number `text` denotes, with
    /// each letter read as its two-digit value.
    public static func remainder(of text: some StringProtocol) throws(Error) -> Int {
        guard !text.isEmpty else { throw .empty }
        var remainder = 0
        for scalar in text.unicodeScalars {
            switch scalar {
            case "0"..."9":
                remainder = (remainder * 10 + scalar.digit) % 97
            case "A"..."Z":
                remainder = (remainder * 100 + scalar.letter) % 97
            default:
                throw .invalidCharacter(scalar)
            }
        }
        return remainder
    }

    /// Whether `text`, check digits included, satisfies MOD 97-10.
    public static func isValid(_ text: some StringProtocol) -> Bool {
        do throws(Error) {
            return try remainder(of: text) == 1
        } catch {
            return false
        }
    }

    /// The check value, 2–98, that makes `text` followed by its two check
    /// digits satisfy MOD 97-10.
    public static func check(for text: some StringProtocol) throws(Error) -> Int {
        98 - (try remainder(of: text) * 100) % 97
    }
}

extension Unicode.Scalar {

    fileprivate var digit: Int {
        Int(value - ("0" as Unicode.Scalar).value)
    }

    fileprivate var letter: Int {
        Int(value - ("A" as Unicode.Scalar).value) + 10
    }
}
