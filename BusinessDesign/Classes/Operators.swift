//
//  Created by Backbase R&D B.V. on 26/09/2018.
//

precedencegroup LeftApplyPrecedence {
    associativity: left
    higherThan: AssignmentPrecedence
    lowerThan: TernaryPrecedence
}

precedencegroup FunctionCompositionPrecedence {
    associativity: right
    higherThan: LeftApplyPrecedence
}

// MARK: - Precedence groups
precedencegroup ForwardApplication {
    associativity: left
}

precedencegroup ForwardComposition {
    associativity: left
    higherThan: ForwardApplication
}

precedencegroup SingleTypeComposition {
    associativity: left
    higherThan: ForwardApplication
}

precedencegroup LensSetPrecedence {
    associativity: left
    higherThan: ForwardComposition
}

infix operator .~ : LensSetPrecedence

// MARK: - Operators
infix operator |>   : ForwardApplication
infix operator <|   : ForwardApplication
infix operator ?>   : ForwardApplication
infix operator *>   : ForwardApplication
infix operator >>>  : ForwardComposition
infix operator <>   : SingleTypeComposition

// MARK: - Implementation
// MARK: -
public func |> <A, B>(a: A, f: (A) -> B) -> B {
    return f(a)
}

public func |> <A>(a: inout A, f: (inout A) -> Void) {
    f(&a)
}

public func *> <A>(a: A, f: (A) -> Void) -> A {
    f(a)
    return a
}

// MARK: -
public func <| <A, B>(f: (A) -> B, a: A) -> B {
    return f(a)
}

// MARK: -
public func ?> <A, B>(a: A?, f: (A) -> B) -> B? {
    guard let a = a else { return nil }
    return f(a)
}

// MARK: - >>>

public func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { a in
        return g(f(a))
    }
}

// MARK: - <>

public func <> <A>(f: @escaping (A) -> A, g: @escaping (A) -> A) -> ((A) -> A) {
    return f >>> g
}

public func <> <A>(f: @escaping (inout A) -> Void, g: @escaping (inout A) -> Void) -> ((inout A) -> Void) {
    return { a in
        f(&a)
        g(&a)
    }
}

public func <> <A: AnyObject>(f: @escaping (A) -> Void, g: @escaping (A) -> Void) -> (A) -> Void {
    return { a in
        f(a)
        g(a)
    }
}

public func <> <A, B>(f: @escaping (A) -> (B) -> Void,
                      g: @escaping (A) -> (B) -> Void) -> (A) -> (B) -> Void {
    return { a in
        return { b in
            f(a)(b)
            g(a)(b)
        }
    }
}

// MARK: - .~

public func .~ <Whole, Part> (lens: WritableKeyPath<Whole, Part>, part: Part) -> (Whole) -> Whole {
    return { whole in
        var copy = whole
        copy[keyPath:lens] = part
        return copy
    }
}
