# swift-iso-7064

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Swift implementation of the ISO/IEC 7064 check character system MOD 97-10.

## Overview

`ISO_7064.MOD_97_10` computes and verifies the pure system MOD 97-10, the check that ISO 13616 (IBAN) and other identifiers use. Digits carry their value; upper-case letters carry 10–35.

```swift
import ISO_7064

try ISO_7064.MOD_97_10.check(for: "794")      // 44
ISO_7064.MOD_97_10.isValid("79444")           // true
```

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
