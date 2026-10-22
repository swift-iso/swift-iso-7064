extension ISO_7064.MOD_97_10 {
    internal static func remainder(
        of text: some StringProtocol
    ) throws(ISO_7064.MOD_97_10.Error) -> Int {
        guard !text.isEmpty else { throw .empty }
        var remainder = 0
        for byte in text.utf8 {
            switch byte {
            case UInt8(ascii: "0")...UInt8(ascii: "9"):
                remainder = (remainder * 10 + Int(byte - UInt8(ascii: "0"))) % 97

            case UInt8(ascii: "A")...UInt8(ascii: "Z"):
                remainder = (remainder * 100 + Int(byte - UInt8(ascii: "A")) + 10) % 97

            default:
                throw .invalidCharacter
            }
        }
        return remainder
    }

    public static func isValid(_ text: some StringProtocol) -> Bool {
        do throws(ISO_7064.MOD_97_10.Error) {
            return try remainder(of: text) == 1
        } catch {
            return false
        }
    }

    public static func check(
        for text: some StringProtocol
    ) throws(ISO_7064.MOD_97_10.Error) -> String {
        let check = 98 - (try remainder(of: text) * 100) % 97
        return check < 10 ? "0\(check)" : "\(check)"
    }
}
