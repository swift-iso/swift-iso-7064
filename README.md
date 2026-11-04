# swift-iso-7064

Use this package when you need to compute or verify ISO/IEC 7064 MOD 97-10 check digits, the check that IBANs and similar identifiers carry. Start from `ISO_7064.MOD_97_10`. To validate an IBAN, which moves its country code and check digits to the end before checking, use swift-iso-13616.

## Laws

- Text is read one ASCII character at a time. A digit counts as its value, and an upper-case letter A to Z counts as the two digits 10 to 35. Lower-case letters, spaces, punctuation and any non-ASCII character are refused.
- Empty text is refused.
- `ISO_7064.MOD_97_10.check(for:)` always returns two digits and keeps a leading zero, as in `08`. Appending them to the text gives text that `ISO_7064.MOD_97_10.isValid(_:)` accepts.
- `ISO_7064.MOD_97_10.isValid(_:)` accepts text whose remainder modulo 97 is 1. It returns false for empty text or a refused character instead of throwing.
- The check digits go at the end of the text. Nothing is rearranged.
- Text of any length works. The remainder is reduced after every character, so long input doesn't overflow.
