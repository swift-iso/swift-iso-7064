extension ISO_7064 {

    /// The pure check character system MOD 97-10.
    ///
    /// A string satisfies MOD 97-10 when its value, read as a decimal number,
    /// leaves a remainder of 1 on division by 97. The two check digits that
    /// produce that remainder are `98 - (n × 100 mod 97)` for the protected
    /// number `n`.
    ///
    /// Digits `0`–`9` carry their own value. Upper-case letters `A`–`Z` carry
    /// the values 10–35 and contribute two decimal digits, the conversion that
    /// ISO 13616 (IBAN) and ISO 11649 (creditor reference) apply before
    /// computing MOD 97-10 over alphanumeric text.
    public enum MOD_97_10 {}
}
