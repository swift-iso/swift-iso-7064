import Testing
@testable import ISO_7064

extension ISO_7064.MOD_97_10 {
    @Suite struct Test {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
    }
}

extension ISO_7064.MOD_97_10.Test.Unit {

    @Test
    func `the standard's numeric example 794 has check digits 44`() throws {
        #expect(try ISO_7064.MOD_97_10.check(for: "794") == "44")
        #expect(ISO_7064.MOD_97_10.isValid("79444"))
    }

    @Test
    func `rearranged IBANs leave a remainder of one`() throws {
        #expect(try ISO_7064.MOD_97_10.remainder(of: "WEST12345698765432GB82") == 1)
        #expect(try ISO_7064.MOD_97_10.remainder(of: "ABNA0417164300NL91") == 1)
    }

    @Test
    func `a single altered digit fails the check`() throws {
        #expect(!ISO_7064.MOD_97_10.isValid("79445"))
        #expect(try ISO_7064.MOD_97_10.remainder(of: "ABNA0417164300NL92") == 2)
    }

    @Test
    func `the check digits for alphanumeric text match the IBAN check digits`() throws {
        #expect(try ISO_7064.MOD_97_10.check(for: "ABNA0417164300NL") == "91")
    }

    @Test
    func `check digits below ten keep their leading zero`() throws {
        #expect(try ISO_7064.MOD_97_10.check(for: "30") == "08")
        #expect(ISO_7064.MOD_97_10.isValid("3008"))
    }
}

extension ISO_7064.MOD_97_10.Test.`Edge Case` {

    @Test
    func `empty text is refused`() {
        #expect(throws: ISO_7064.MOD_97_10.Error.empty) {
            try ISO_7064.MOD_97_10.remainder(of: "")
        }
        #expect(!ISO_7064.MOD_97_10.isValid(""))
    }

    @Test(arguments: ["12a", "12 34", "1٣", "1\u{301}2", "١٢"])
    func `lower-case letters, punctuation and non-ASCII scalars are refused`(text: String) {
        #expect(throws: ISO_7064.MOD_97_10.Error.invalidCharacter) {
            try ISO_7064.MOD_97_10.remainder(of: text)
        }
    }

    @Test
    func `long input does not overflow`() throws {
        let digits = String(repeating: "9", count: 400)
        #expect(try ISO_7064.MOD_97_10.remainder(of: digits) < 97)
    }
}
