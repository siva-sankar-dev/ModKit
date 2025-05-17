//
//  PriceFormatterTests.swift
//  ModKit
//
//  Created by Siva Sankar on 17/05/25.
//

import ModKit
import Testing

@Suite("Price Formatter Tests with Extentions")
struct PriceFormatterTests {
    @Test("String.formattedAsPrice formats prices with symbols correctly")
    func testStringFormattedAsPriceWithSymbols() {
        // US Dollars
        #expect("1299.99".formattedAsPrice(in: .usd) == "$1,299.99")
        #expect("0".formattedAsPrice(in: .usd) == "$0.00")
        #expect("1000000".formattedAsPrice(in: .usd) == "$10,00,000.00")

        // Indian Rupees
        #expect("1299.99".formattedAsPrice(in: .inr) == "₹1,299.99")
        #expect("9999".formattedAsPrice(in: .inr) == "₹9,999.00")

        // Japanese Yen (no decimals)
        #expect("1299.99".formattedAsPrice(in: .jpy) == "¥1,300")
        #expect("1299".formattedAsPrice(in: .jpy) == "¥1,299")

        // Euro
        #expect("1299.99".formattedAsPrice(in: .eur) == "€1,299.99")

        // Swedish Krona (suffix symbol)
        #expect("1299.99".formattedAsPrice(in: .sek) == "1,299.99 kr")
    }

    @Test(
        "String.formattedAsPrice formats prices with currency codes correctly"
    )
    func testStringFormattedAsPriceWithCodes() {
        #expect(
            "1299.99".formattedAsPrice(in: .usd, displayStyle: .code)
                == "USD1,299.99"
        )
        #expect(
            "1299.99".formattedAsPrice(in: .eur, displayStyle: .code)
                == "EUR1,299.99"
        )
        #expect(
            "1299.99".formattedAsPrice(in: .jpy, displayStyle: .code)
                == "JPY1,300"
        )
        #expect(
            "1299.99".formattedAsPrice(in: .sek, displayStyle: .code)
                == "1,299.99 SEK"
        )
    }

    @Test("String.formattedAsPrice handles invalid inputs correctly")
    func testStringFormattedAsPriceWithInvalidInputs() {
        #expect("abc".formattedAsPrice(in: .usd) == nil)
        #expect("12.34.56".formattedAsPrice(in: .eur) == nil)
        #expect("".formattedAsPrice(in: .jpy) == nil)
    }

    @Test("String.formattedAsPrice works with custom currencies")
    func testStringFormattedAsPriceWithCustomCurrencies() {
        let bitcoin = Currency.custom(
            code: "BTC",
            symbol: "₿",
            position: .prefix
        )
        let baht = Currency.custom(code: "THB", symbol: "฿", position: .suffix)

        #expect("0.45".formattedAsPrice(in: bitcoin) == "₿0.45")
        #expect(
            "0.45".formattedAsPrice(in: bitcoin, displayStyle: .code)
                == "BTC0.45"
        )
        #expect("199.99".formattedAsPrice(in: baht) == "199.99 ฿")
        #expect(
            "199.99".formattedAsPrice(in: baht, displayStyle: .code)
                == "199.99 THB"
        )
    }

    @Test("String.formattedAsPrice works with custom symbols")
    func testStringFormattedAsPriceWithCustomSymbols() {
        #expect("1299.99".formattedAsPrice(withSymbol: "₿") == "₿1,299.99")
        #expect(
            "1299.99".formattedAsPrice(withSymbol: "kr", isPrefix: false)
                == "1,299.99kr"
        )
        #expect(
            "1299.99".formattedAsPrice(withSymbol: "£", decimalPlaces: 0)
                == "£1,300"
        )
    }

    @Test("Double.formattedAsPrice formats prices correctly")
    func testDoubleFormattedAsPrice() {
        // With currency symbols
        #expect(1299.99.formattedAsPrice(in: .usd) == "$1,299.99")
        #expect(0.0.formattedAsPrice(in: .eur) == "€0.00")
        #expect(1000000.0.formattedAsPrice(in: .gbp) == "£10,00,000.00")

        // With currency codes
        #expect(
            1299.99.formattedAsPrice(in: .usd, displayStyle: .code)
                == "USD1,299.99"
        )
        #expect(
            1299.99.formattedAsPrice(in: .jpy, displayStyle: .code)
                == "JPY1,300"
        )

        // Without grouping
        #expect(
            1000000.0.formattedAsPrice(in: .usd, useGrouping: false)
                == "$1000000.00"
        )
    }

    @Test("Int.formattedAsPrice formats prices correctly")
    func testIntFormattedAsPrice() {
        // With currency symbols
        #expect(1299.formattedAsPrice(in: .usd) == "$1,299.00")
        #expect(0.formattedAsPrice(in: .eur) == "€0.00")
        #expect(1_000_000.formattedAsPrice(in: .gbp) == "£10,00,000.00")

        // With currency codes
        #expect(
            1299.formattedAsPrice(in: .usd, displayStyle: .code)
                == "USD1,299.00"
        )
        #expect(
            1299.formattedAsPrice(in: .jpy, displayStyle: .code) == "JPY1,299"
        )

        // Without grouping
        #expect(
            1_000_000.formattedAsPrice(in: .usd, useGrouping: false)
                == "$1000000.00"
        )
    }

    @Test("Currency.code returns correct ISO codes")
    func testCurrencyCodes() {
        #expect(Currency.usd.code == "USD")
        #expect(Currency.eur.code == "EUR")
        #expect(Currency.gbp.code == "GBP")
        #expect(Currency.jpy.code == "JPY")
        #expect(Currency.inr.code == "INR")

        let custom = Currency.custom(
            code: "XYZ",
            symbol: "Ж",
            position: .prefix
        )
        #expect(custom.code == "XYZ")
    }

    @Test("Currency.symbol returns correct symbols")
    func testCurrencySymbols() {
        #expect(Currency.usd.symbol == "$")
        #expect(Currency.eur.symbol == "€")
        #expect(Currency.gbp.symbol == "£")
        #expect(Currency.jpy.symbol == "¥")
        #expect(Currency.inr.symbol == "₹")

        let custom = Currency.custom(
            code: "XYZ",
            symbol: "Ж",
            position: .prefix
        )
        #expect(custom.symbol == "Ж")
    }

    @Test("Currency.symbolPosition returns correct positions")
    func testCurrencySymbolPositions() {
        #expect(Currency.usd.symbolPosition == .prefix)
        #expect(Currency.sek.symbolPosition == .suffix)

        let prefixCustom = Currency.custom(
            code: "XYZ",
            symbol: "Ж",
            position: .prefix
        )
        #expect(prefixCustom.symbolPosition == .prefix)

        let suffixCustom = Currency.custom(
            code: "ABC",
            symbol: "Ж",
            position: .suffix
        )
        #expect(suffixCustom.symbolPosition == .suffix)
    }

    @Test("Currency decimal handling works correctly")
    func testCurrencyDecimalHandling() {
        #expect(Currency.usd.usesDecimals)
        #expect(Currency.eur.usesDecimals)
        #expect(!Currency.jpy.usesDecimals)
        #expect(!Currency.krw.usesDecimals)

        #expect(Currency.usd.decimalPlaces == 2)
        #expect(Currency.jpy.decimalPlaces == 0)
    }

    @Test("Formatting works with different grouping settings")
    func testGroupingSettings() {
        // With grouping (default)
        #expect("1000000".formattedAsPrice(in: .usd) == "$10,00,000.00")

        // Without grouping
        #expect(
            "1000000".formattedAsPrice(in: .usd, useGrouping: false)
                == "$1000000.00"
        )
    }

    @Test("Edge case testing")
    func testEdgeCases() {
        // Very large numbers
        #expect("999999999.99".formattedAsPrice(in: .usd) == "$99,99,99,999.99")

        // Very small numbers
        #expect("0.001".formattedAsPrice(in: .usd) == "$0.00")  // Rounds to 2 decimals

        // Negative numbers
        #expect("-50.25".formattedAsPrice(in: .usd) == "$-50.25")
    }
}
