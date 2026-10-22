extension ISO_7064.MOD_97_10 {

    public enum Error: Swift.Error, Sendable, Equatable {

        /// The text contains no characters to check.
        case empty

        /// The text contains a character other than `0`–`9` or `A`–`Z`.
        case invalidCharacter(Unicode.Scalar)
    }
}
