//
//  Currency.swift
//  ModKit
//
//  Created by Siva Sankar on 17/05/25.
//

/// Currency enum representing common world currencies with their symbols and formatting options
public enum Currency {
    case usd     // US Dollar
    case eur     // Euro
    case gbp     // British Pound
    case jpy     // Japanese Yen
    case inr     // Indian Rupee
    case cny     // Chinese Yuan
    case cad     // Canadian Dollar
    case aud     // Australian Dollar
    case chf     // Swiss Franc
    case rub     // Russian Ruble
    case krw     // South Korean Won
    case brl     // Brazilian Real
    case zar     // South African Rand
    case mxn     // Mexican Peso
    case sgd     // Singapore Dollar
    case hkd     // Hong Kong Dollar
    case nzd     // New Zealand Dollar
    case thb     // Thai Baht
    case sek     // Swedish Krona
    case dkk     // Danish Krone
    case custom(code: String, symbol: String, position: SymbolPosition)
    
    /// Enum to specify whether currency symbol appears before or after the amount
    public enum SymbolPosition {
        case prefix
        case suffix
    }
    
    /// Enum to specify whether to use the currency symbol or code
    public enum DisplayStyle {
        case symbol  // Use currency symbol (e.g., "$")
        case code    // Use currency code (e.g., "USD")
    }
    
    /// Returns the currency code (ISO 4217)
    public var code: String {
        switch self {
        case .usd: return "USD"
        case .eur: return "EUR"
        case .gbp: return "GBP"
        case .jpy: return "JPY"
        case .inr: return "INR"
        case .cny: return "CNY"
        case .cad: return "CAD"
        case .aud: return "AUD"
        case .chf: return "CHF"
        case .rub: return "RUB"
        case .krw: return "KRW"
        case .brl: return "BRL"
        case .zar: return "ZAR"
        case .mxn: return "MXN"
        case .sgd: return "SGD"
        case .hkd: return "HKD"
        case .nzd: return "NZD"
        case .thb: return "THB"
        case .sek: return "SEK"
        case .dkk: return "DKK"
        case .custom(let code, _, _): return code
        }
    }
    
    /// Returns the currency symbol
    public var symbol: String {
        switch self {
        case .usd: return "$"
        case .eur: return "€"
        case .gbp: return "£"
        case .jpy: return "¥"
        case .inr: return "₹"
        case .cny: return "¥"
        case .cad: return "CA$"
        case .aud: return "A$"
        case .chf: return "CHF"
        case .rub: return "₽"
        case .krw: return "₩"
        case .brl: return "R$"
        case .zar: return "R"
        case .mxn: return "MX$"
        case .sgd: return "S$"
        case .hkd: return "HK$"
        case .nzd: return "NZ$"
        case .thb: return "฿"
        case .sek: return "kr"
        case .dkk: return "kr"
        case .custom(_, let symbol, _): return symbol
        }
    }
    
    /// Indicates whether the symbol should be placed before or after the amount
    public var symbolPosition: SymbolPosition {
        switch self {
        case .sek, .dkk, .thb:
            return .suffix
        case .custom(_, _, let position):
            return position
        default:
            return .prefix
        }
    }
    
    /// Returns whether the currency typically displays decimal places
    public var usesDecimals: Bool {
        switch self {
        case .jpy, .krw:
            return false
        default:
            return true
        }
    }
    
    /// Returns the number of decimal places typically used for this currency
    public var decimalPlaces: Int {
        return usesDecimals ? 2 : 0
    }
}
