//
//  Optional+Extension.swift
//  ModKit
//
//  Created by Siva Sankar on 19/05/25.
//

import Foundation

extension Optional {
    /// Returns `true` if the optional is `nil`.
    public var isNil: Bool {
        return self == nil
    }

    /// Returns `true` if the optional contains a value.
    public var isSome: Bool {
        return self != nil
    }

    /// Returns the optional value or a default value if nil.
    public func or(_ defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }

    /// Executes a closure if the optional is non-nil.
    public func ifSome(_ action: (Wrapped) -> Void) {
        if let value = self {
            action(value)
        }
    }

    /// Executes a closure if the optional is nil.
    public func ifNil(_ action: () -> Void) {
        if self == nil {
            action()
        }
    }

    /// Optional ternary-style expression
    public func then<T>(_ some: (Wrapped) -> T, else none: @autoclosure () -> T)
        -> T
    {
        switch self {
        case .some(let value): return some(value)
        case .none: return none()
        }
    }
}
